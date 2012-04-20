(define reverse
  (lambda (ls)
    (if (null? ls)
        '()
        (append (reverse (cdr ls)) (list (car ls))))))

(define reverse!
  (lambda (ls)
    (reverse!-help ls ls)))
    
(define reverse!-help
  (lambda (ls1 ls2)
    (if (null? ls2)
        '()
        (set-car! ls1 (car ls2)))))