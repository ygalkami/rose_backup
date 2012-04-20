(define firsts
  (lambda (ls)
    (map car ls)))

(define positives
  (lambda (lst)
    (cond [(null? lst) '()]
          [(positive? (car lst)) 
           (cons (car lst) (positives (cdr lst)))]
          [else (positives (cdr lst))])))

(define positives2
  (lambda (lst)
    (if (null? lst)
        '()
        (let ([rest (positives (cdr lst))])
          (if (positive? (car lst))
              (cons (car lst) rest)
              rest)))))

(define map
    (lambda (f ls)
      (if (null? ls)
          '()
          (cons (f (car ls))
                (map f (cdr ls))))))

(define list-sum
  (lambda (ls)
    (if (null? ls)
        0
        (+ (car ls) (list-sum (cdr ls))))))

(define largest-in-list
  (lambda (ls)
    (cond [(null? ls) (eopl:error "empty list has no largest value")]
          [(null? (cdr ls) (car ls))]
          [else (max (car ls) (largest-in-list (cdr ls)))])))

(define andmap
  (lambda (func ls)
    (or (null? ls)
        (and (func (car ls))
             (andmap func (cdr ls))))))
        