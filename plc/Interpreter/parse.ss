; This is a parser for simple Scheme expressions, such as those in EOPL, 3.1 thru 3.3.

; You will want to replace this with your parser that includes more expression types, more options for these types, and error-checking.

; Procedures to make the parser a little bit saner.
(define 1st car)
(define 2nd cadr)
(define 3rd caddr)

(define parse-exp         
  (lambda (datum)
    (cond
     [(symbol? datum) (var-exp datum)]
     [(or (number? datum)
          (string? datum)
          (vector? datum)
          (boolean? datum)
          (null? datum)) (lit-exp datum)]
     [(pair? datum)
      (cond
       [(and (eqv? (car datum) 'lambda) (validate-lambda datum))
           (lambda-exp (cadr datum)
                       (map parse-exp (cddr datum)))]
       [(and (eqv? (car datum) 'if) (validate-if datum) (eq? (length datum) 4))
        (if-exp (parse-exp (cadr datum)) (parse-exp (caddr datum)) (parse-exp (cadddr datum)))]
       [(and (eqv? (car datum) 'if) (validate-if datum))
        (if-2-exp (parse-exp (cadr datum)) (parse-exp (caddr datum)))]
       [(eqv? (car datum) 'while)
        (while-exp (parse-exp (cadr datum)) (map parse-exp (cddr datum)))]
       [(and (or (eqv? (car datum) 'let)
            (eqv? (car datum) 'let*)
            (eqv? (car datum) 'letrec))
             (validate-let datum))
           (if (null? (cadr datum))
               (begin-exp (map parse-exp (cddr datum)))
               (let-exp (if (eqv? (car datum) 'let)
                        'let
                        (car datum))
                    (map car (cadr datum))
                    (map parse-exp (map cadr (cadr datum)))
                    (map parse-exp (cddr datum))))]
       [(and (eqv? (car datum) 'let)
             (validate-named-let datum)) (named-let-exp (cadr datum)
                                                        (map car (caddr datum))
                                                        (map parse-exp (map cadr (caddr datum)))
                                                        (map parse-exp (cdddr datum)))]
       [(eqv? (car datum) 'quote) (if (= (length datum) 2)
                                      (quote-exp (cadr datum))
                                      (eopl:error 'parse-exp "bad quote: ~s" datum))]
       [(eqv? (car datum) 'begin) (begin-exp (map parse-exp (cdr datum)))]
       [(eqv? (car datum) 'cond) (cond-exp (map parse-exp (map car (cdr datum))) (map parse-exp (map cadr (cdr datum))))]
       [(eqv? (car datum) 'case) (case-exp (cadr datum) (map car (cddr datum)) (map parse-exp (map cadr (cddr datum))))]
       [(eqv? (car datum) 'set!) (set!-exp (cadr datum) (parse-exp (caddr datum)))]
       [(eqv? (car datum) 'and) (and-exp (map parse-exp (cdr datum)))]
       [(eqv? (car datum) 'or) (or-exp (map parse-exp (cdr datum)))]
       [(eqv? (car datum) 'define) (define-exp (cadr datum) (parse-exp (caddr datum)))]
       [(eqv? (car datum) 'ref) datum]
       [else (app-exp (parse-exp (1st datum))
		      (map parse-exp (cdr datum)))])]
     [else (eopl:error 'parse-exp "bad expression: ~s" datum)])))

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
      (begin-exp (bodies)
                 (list 'begin (map unpars-exp bodies)))
      (cond-exp (conds bodies)
                (list 'cond (map unparse-exp conds) (map unparse-exp bodies)))
      (case-exp (test lists bodies)
                (list 'case test lists bodies))
      (and-exp (bodies)
               (list 'and (map unparse-exp bodies)))
      (or-exp (bodies)
              (list 'or (map unparse-exp bodies)))
      (define-exp (var exp)
        (list 'define var (unparse-exp exp)))
      (app-exp (rator rands)
        (list rator (map unparse-exp rands))))))


(define validate-lambda
  (lambda (datum)
    (if (> (length datum) 2)
        (cond ;((and (list? (cadr datum)) ((set-of symbol?) (cadr datum)) (not (andmap null? (cddr datum)))) #t)
          ((and (list? (cadr datum)) (not (andmap null? (cddr datum)))) #t)
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
                 ((list-of symbol?) (map car (cadr datum))))
            #t
            #f)
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







