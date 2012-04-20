(define bt-recur
  (lambda (num-function tree-function)
    (letrec ([helper
              (lambda (bt)
                 (if (number? bt)
                     (num-function bt)
                     (if (null? bt)
                         '()
                         (tree-function (car bt)
                                        (helper (cadr bt))
                                        (helper (caddr bt))))))])
      helper)))


;Problem 1-a
(define bt-sum
  (bt-recur + (lambda (node x y) (+ x y))))

;Problem 1-b
(define bt-inorder
  (bt-recur (lambda (x) '()) (lambda (node x y) (append x (cons node y)))))

;Problem 2
(define make-slist-leaf-iterator
  (lambda (sls)
    (let ((ls sls))
      (lambda ()
        (set! ls (leaf-help ls))
        (cond ((null? ls) #f)
              (else (set! sls (car ls)) (set! ls (cdr ls)) sls))))))
      
(define leaf-help
  (lambda (ls)
    (cond ((null? ls) '())
          ((null? (car ls)) (leaf-help (cdr ls)))
          ((pair? (car ls)) (leaf-help (append (car ls) (cdr ls))))
          (else ls))))

;Problem 3
(define subst-leftmost
  (lambda (new old lst pred)
    (if (null? lst) 
        '()
        (cdr (subst-leftmost-help new old lst pred)))))

(define subst-leftmost-help
  (lambda (new old lst pred)
    (cond ((null? lst) (list #f)) 
          ((or (number? lst) (symbol? lst)) (if (pred old lst) (cons #t new) (cons #f lst)))
          ((pair? lst)
           (let ((result (subst-leftmost-help new old (car lst) pred)))
             (if (car result)
                 (cons #t (cons (cdr result) (cdr lst)))
                 (let ((result2 (subst-leftmost-help new old (cdr lst) pred)))
                   (if (car result2)
                       (cons #t (cons (cdr result) (cdr result2)))
                       (cons #f lst)))))))))