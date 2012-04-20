(define largest-in-lists
  (lambda (lst)
  (letrec ((largest-in-list 
    (lambda (ls)
      (if (null? ls)
          0
          (if (equal? (length ls) 1)
              (car ls)
              (cons (largest-in-list (car ls)) (largest-in-list (cdr ls))))))))
    (cond [(null? lst) 0]
          [(equal? (length lst) 1) (car lst)]
          [else (max (car lst) (largest-in-list (cdr lst)))]))))
