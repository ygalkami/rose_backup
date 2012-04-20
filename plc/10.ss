(define-datatype expression expression?  ; based on the simple expression grammar, EoPL-2 p6
  (lit-exp
   (id (lambda (x) (or (symbol? x) (boolean? x) (number? x) (string? x) (vector? x) (null? x)))))
  (lambda-exp
    (id (lambda (x) (or (symbol? x) (pair? x) (null? x))))
    (body (list-of expression?)))
  (app-exp
    (rator (lambda (x) (map expression? x))))
  (let-exp
   (kind symbol?)
   (assignments expression?)
   (body (list-of expression?)))
  (named-let-exp
   (name symbol?)
   (assignments expression?)
   (body (list-of expression?)))
  (set!-exp
   (var symbol?)
   (body expression?))
  (if-exp
   (test-exp expression?)
   (true-exp expression?)
   (false-exp expression?))
  (if-2-exp
   (test-exp expression?)
   (true-exp expression?)))

(define list-of
  (lambda (pred) 
    (lambda (val)
      (or (null? val)
          (and (pair? val)
               (pred (car val))
               ((list-of pred) (cdr val)))))))

(define parse-exp
  (lambda (datum)
    (cond ((or (symbol? datum) 
               (boolean? datum)
               (number? datum)
               (string? datum)
               (null? datum)
               (vector? datum))
           (lit-exp datum))
          ((and (eqv? (car datum) 'lambda) (validate-lambda datum))
           (lambda-exp (cadr datum)
                       (map parse-exp (cddr datum))))
          ((and (eqv? (car datum) 'if) (validate-if datum) (eq? (length datum) 4))
           (if-exp (parse-exp (cadr datum)) (parse-exp (caddr datum)) (parse-exp (cadddr datum))))
          
          ((and (eqv? (car datum) 'if) (validate-if datum))
           (if-2-exp (parse-exp (cadr datum)) (parse-exp (caddr datum))))
          
          ((and (eqv? (car datum) 'set!) (validate-set datum))
           (set!-exp (cadr datum) (parse-exp (caddr datum))))
          
          ((and (eqv? (car datum) 'let)
                (> (length datum) 1)
                (symbol? (cadr datum))
                (validate-named-let datum))
           (named-let-exp (cadr datum) (parse-exp (caddr datum)) (map parse-exp (cdddr datum))))
          
          ((and (or (eqv? (car datum) 'let)
                    (eqv? (car datum) 'let*)
                    (eqv? (car datum) 'letrec))
                (validate-let datum))
           (let-exp (car datum) (parse-exp (cadr datum)) (map parse-exp (cddr datum))))
          (else
           (if (list? datum)
               (app-exp
                (map parse-exp datum))
               (eopl:error 'parse-exp "Not a proper list ~s" datum))))))

(define validate-lambda
  (lambda (datum)
    (if (> (length datum) 2)
        (cond ((and (list? (cadr datum)) ((set-of symbol?) (cadr datum)) (not (andmap null? (cddr datum)))) #t)
              ((and (symbol? (cadr datum)) (not (andmap null? (cddr datum)))) #t)
              ((and (pair? (cadr datum)) (improper-set? (cadr datum)) (not (list? (cadr datum))) (not (andmap null? (cddr datum)))) #t)
              (else
               (eopl:error 'parse-exp "Invalid Lambda expression ~s" datum)))
        (eopl:error 'parse-exp "Wrong number of args for lambda expression ~s" datum))))

(define improper-set?
  (lambda (x)
    (and (pair? x)  (not (list? x)) (not (equal? (car x) (cdr x))))))


(define validate-named-let
  (lambda (datum)
    (if (> (length datum) 3)
        (if (and (andmap list? (caddr datum))
                 ((set-of symbol?) (map car (caddr datum))))
            #t
            (eopl:error 'parse-exp "Invalid let ~s" datum))
        (eopl:error 'parse-exp "Invalid let ~s" datum))))

(define validate-let
  (lambda (datum)
    (if (> (length datum) 2)
        (if (and (list? (cadr datum))
                 (list-of-2-lists? (cadr datum))
                 ((set-of symbol?) (map car (cadr datum))))
            #t
            (eopl:error 'parse-exp "Invalid let 1 ~s" datum))
        (eopl:error 'parse-exp "Invalid let 2 ~s" datum))))

(define valid-let-arg2?
  (lambda (datum)
    (and (list? datum)
         (list-of-l2list? datum) 
         ((set-of symbol?) (map car datum)))))


(define list-of-2-lists?
  (lambda (lst)
    (if (null? lst)
        #t
        (if (and (list? (car lst)) (= (length (car lst)) 2))
            (list-of-2-lists? (cdr lst))
            #f))))

                 
(define set-of
  (lambda (expr)
    (lambda (datum)
      (and ((list-of expr) datum) 
           (let loop ([datum datum])
             (if (null? datum)
                 #t
                 (if (member (car datum) (cdr datum))
                     #f
                     (loop (cdr datum)))))))))	

(define validate-set
  (lambda (ls)
    (if (and (eq? (length ls) 3) (symbol? (cadr ls)))
        #t
        (eopl:error 'parse-exp "Invalid set! ~s" ls))))
    
(define validate-if
  (lambda (datum)
    (if (or (eq? (length datum) 3) (eq? (length datum) 4))
        #t
        (eopl:error 'parse-exp "Invalid if ~s" datum))))

(define andmap
  (lambda (func ls)
    (or (null? ls)
        (and (func (car ls))
             (andmap func (cdr ls))))))

(define unparse-exp ; an inverse for parse-exp
  (lambda (exp)
    (cases expression exp
      (lit-exp (id) id)
      (lambda-exp (id body) 
        (append (list 'lambda id)
          (map unparse-exp body)))
      (if-exp (test-exp true-exp false-exp)
              (list 'if (unparse-exp test-exp) 
                    (unparse-exp true-exp) 
                    (unparse-exp false-exp)))
      (if-2-exp (test-exp true-exp)
               (list 'if (unparse-exp test-exp)
                     (unparse-exp true-exp)))
      (named-let-exp (name assignments body)
                     (append (list 'let name (unparse-exp assignments)) (map unparse-exp body)))
      (let-exp (kind assignments body)
               (append (list kind (unparse-exp assignments)) (map unparse-exp body)))
      (set!-exp (var body)
                (list 'set! var (unparse-exp body)))
      (app-exp (rator)
        (map unparse-exp rator)))))