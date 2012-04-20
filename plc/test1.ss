(define nearest-number
  (lambda (num ls)
    (nearest-num-help num (cdr ls) (abs (- num (car ls))) (car ls))))
     
(define nearest-num-help
  (lambda (num ls diff cur)
    (if (null? ls)
        cur
        (if (> (abs (- num (car ls))) diff)
            (nearest-num-help num (cdr ls) diff cur)
            (nearest-num-help num (cdr ls) (abs (- num (car ls))) (car ls))))))

(define reflexive?
  (lambda (ls)
    (if (null? ls)
        #t
        (if (all-exist? ls (get-els ls))
            #t
            #f))))
        
(define all-exist?
  (lambda (ls1 els)
    (if (null? els)
        #t
        (if (not (member (list (car els) (car els)) ls1))
            #f
            (all-exist? ls1 (cdr els))))))
           
(define get-els
  (lambda (ls)
    (if (null? ls)
        '()
        (append (car ls) (get-els (cdr ls))))))