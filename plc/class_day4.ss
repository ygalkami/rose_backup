(define length
  (lambda (ls)
    (if (null? ls)
        0
        (+ 1 (length (cdr ls))))))

(define fact
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact (- n 1))))))

(define fact-tail
  (lambda (n accum)
    (if (zero? n)
        accum
        (fact-tail (- n 1) (* n accum)))))

(define make-list
  (lambda (n obj)
    (if (zero? n)
        '()
        (cons obj (make-list (- n 1) obj)))))

(define firsts
  (lambda (list-of-lists
           (if (null? list-of-lists)
               '()
               (cons (caar list-of-lists) (firsts (cdr list-of-lists)))))))

(define firsts
  (lambda (ls)
    (map car ls)))