;Assignment 2, Written by David Pick 3/13/09
(define fact
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact (- n 1))))))

(define choose
  (lambda (n k)
    (/ (fact n) (* (fact k) (fact (- n k))))))

(define make-list
  (lambda (n obj)
    (if (zero? n)
        '()
        (cons obj (make-list (- n 1) obj)))))

(define make-range
  (lambda (x y)
    (if (= x y)
        (list x)
        (cons x (make-range (+ x 1) y)))))

(define curry2
  (lambda (function)
    (lambda (x)
      (lambda (y)
        (function x y)))))

(define curried-compose
  (lambda (func1)
    (lambda (func2)
      (lambda (x)
        (func1 (func2 x))))))

(define compose
  (lambda (func1 func2 . func3)
    (if (null? func3)
        ((curried-compose func1) func2)
        (compose func1 (compose func2 (car func3))))))

(define make-list-c
  (lambda (num)
    (lambda (obj)
      (if (zero? num)
          '()
          (cons obj ((make-list-c (- num 1)) obj))))))

(define set?
  (lambda (set)
    (if (equal? set '())
        #t
        (if (set-contains? set (car set))
            #f
            (set? (cdr set))))))

(define set-contains?
  (lambda (x y)
    (if (equal? (length x) 1)
        #f
        (if (equal? (cadr x) y)
            #t
            (set-contains? (cdr x) y)))))  

(define intersection
  (lambda (list1 list2)
    (cond ((null? list1) '())
          ((member (car list1) list2)
           (cons (car list1)
                 (intersection (cdr list1) list2)))
          (else (intersection (cdr list1) list2)))))