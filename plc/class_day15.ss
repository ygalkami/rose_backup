(define n-list-sum
  (let ((count 0))
  (case-lambda (nlist)
    (set! count (+ 1 count))
    (display count)
    (cond [(null? nlist) 0]
          [(number? (car nlist))
           (+ (car nlist) (n-list-sum (cdr nlist)))]
          [else (+ (n-list-sum (car nlist)) (n-list-sum (cdr nlist)))]))))