;Assignment 1, Written by David Pick
(define Fahrenheit->Celsius
  (lambda (temp)
         (* (- temp 32) 5/9)))

(define interval-contains?
  (lambda (interval number)
    (cond ((< number (car interval)) #f)
          ((> number (car (cdr interval))) #f)
          (else #t))))

(define interval-intersects?
  (lambda (i1 i2)
    (cond ((interval-contains? i1 (car i2)) #t)
          ((interval-contains? i1 (car (cdr i2))) #t)
          ((interval-contains? i2 (car i1)) #t)
          ((interval-contains? i2 (car (cdr i1))) #t)
          (else #f))))

(define interval-union
  (lambda (i1 i2)
    (cond ((interval-intersects? i1 i2) (list (list (min (car i1) (car i2)) (max (car (cdr i1)) (car (cdr i2))))))
          (else (list i1 i2)))))

(define divisible-by-7?
  (lambda (num)
    (cond ((= (modulo num 7) 0) #t)
          (else #f))))

(define ends-with-7?
  (lambda (num)
    (cond ((= (modulo num 10) 7) #t)
          (else #f))))

(define fact
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact (- n 1))))))

(define choose
  (lambda (n k)
    (/ (fact n) (* (fact k) (fact (- n k))))))