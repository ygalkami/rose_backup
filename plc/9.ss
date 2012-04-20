;Assignment 9, Written by David Pick
;Problem 1-A
(define-syntax my-let
 (syntax-rules ()
   [(_ ((x v) ...) e1 e2 ...)
    ((lambda (x ...) e1 e2 ...) 
     v ...)]
   ((_ y ((x v) ...) e1 e2 ...)
    (letrec ((y (lambda (x ...) e1 e2 ...)))
      (y v ...)))))

(define-syntax my-or
  (syntax-rules ()
    ((_) #f)
    ((_ exp) exp)
    ((_ exp exp2 ...)
     (if exp
         #t
         (my-or exp2 ...)))))

(define-syntax +=
  (syntax-rules ()
    ((_ x y)
     (begin (set! x (+ x y))
            x))))

(define-syntax return-first
  (syntax-rules ()
    ((_) (begin))
    ((_ expression) expression)
    [(_ e1 e2 ...)
     (let ([e e1])
       (begin e2 ... e))]))
                       
(define-datatype bintree bintree?
  (leaf-node
   (datum number?))
  (interior-node
   (key symbol?)
   (left-tree bintree?)
   (right-tree bintree?)))

(define bintree-to-list
  (lambda (bt)
    (cases bintree bt
      (leaf-node (datum) (list 'leaf-node datum))
      (interior-node (datum left right) (list 'interior-node datum 
                                              (bintree-to-list left)
                                              (bintree-to-list right))))))

(define max-interior
 (lambda (tree)
   (car (max-interior-helper tree))))


(define max-interior-helper
 (lambda (tree)
   (cases bintree tree
     (leaf-node (datum) datum)
     (interior-node (node left right)
                    (largest-interior node (max-interior-helper left)
(max-interior-helper right))))))

(define largest-interior
 (lambda (node left right)
   (cond
     [(and (number? left) (number? right)) (list node (+ left right) (+
left right))]
     [(number? left)
      (if (> (+ left (cadr right)) (cadr right))
          (list node (+ left (cadr right)) (+ left (caddr right)))
          (list (car right) (cadr right) (+ left (caddr right))))]
     [(number? right)
      (if (> (+ right (cadr left)) (cadr left))
          (list node (+ right (cadr left)) (+ right (caddr left)))
          (list (car left) (cadr left) (+ right (caddr left))))]
     [else
      (cond
        [(and (> (+ (caddr left) (caddr right)) (cadr left)) (> (+
(caddr left) (caddr right)) (cadr right)))
         (list node (+ (caddr left) (caddr right)) (+ (caddr left)
(caddr right)))]
        [(> (cadr left) (cadr right))
         (list (car left) (cadr left) (+ (caddr left) (caddr right)))]
        [else
         (list (car right) (cadr right) (+ (caddr left) (caddr
right)))])])))

(define leaf-sum
  (lambda (bt)
    (cases bintree bt
      (leaf-node (datum) datum)
      (interior-node (node left right)
                     (+ (leaf-sum left) (leaf-sum right))))))