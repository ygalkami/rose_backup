(define sn-list-recur
  (lambda (base-value proc list-proc)
    (letrec
        ([helper
          (lambda (ls)
            (cond ((null? ls) base-value)
                  ((list? (car ls)) (list-proc (helper (car ls)) (helper (cdr ls))))
                  (else (proc (car ls) (helper (cdr ls))))))])
      helper)))

;Problem 1
(define sn-list-sum
    (sn-list-recur 0 + +))

;Problem 2
(define sn-list-map
  (lambda (proc ls)
    ((sn-list-recur '() (lambda (x y) (cons (proc x) y)) (lambda (x y) (cons x y))) ls)))

;Problem 3
(define paren-count
  (sn-list-recur 2 (lambda (x y) (+ 0 y)) (lambda (x y) (+ x y))))

;Problem 4
(define sn-list-reverse
  (sn-list-recur '() (lambda (x y) (append y (list x))) (lambda (x y) (append y (list x)))))

;Problem 5
(define sn-list-occur
  (lambda (s snls)
    ((sn-list-recur 0 (lambda (x y) (if (eq? x s) (+ 1 y) y)) (lambda (x y) (+ x y))) snls)))

;Problem 6
(define depth
  (sn-list-recur 1 (lambda (x y) y) (lambda (x y) (max (+ 1 x) y))))