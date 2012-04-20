;Assignemnt 11, written by David Pick, 4/25/09
;Prolbem 1-a
(define member?-cps
  (lambda (item lst k)
    (if (null? lst)
        (k #f)
        (member?-cps item (cdr lst) (lambda (v)
                                      (if (eq? item (car lst))
                                          (k #t)
                                          (k v)))))))

;Problem 1-b
(define set?-cps
  (lambda (ls k)
    (cond ((null? ls) (k #t))
          ((not (pair? ls)) (k #f))
          (else (member?-cps (car ls) (cdr ls) (lambda (v)
                                                 (if (not v)
                                                     (set?-cps (cdr ls) k)
                                                     (k #f))))))))

;Problem 1-c
(define intersection-cps
  (lambda (los1 los2 k)
    (if
     (null? los1)
     (k '())
     (intersection-cps (cdr los1)
		       los2
		       (lambda (v)
			 (memq-cps (car los1)
				   los2
				   (lambda (memq)
				     (k
				      (if memq
					 (cons (car los1) v)
					 v)))))))))

(define memq-cps
  (lambda (sym ls k)
    (cond[(null? ls) (k #f)]
         [(eq? sym (car ls)) (k #t)]
         [else (memq-cps sym (cdr ls) k)])))

;Problem 1-d
(define make-cps
  (lambda (func)
    (lambda (ls k)
      (k (func ls)))))

;Problem 1-e
(define andmap-cps
  (lambda (func-cps ls k)
    (if (null? ls)
      (k #t)
      (func-cps (car ls) (lambda (v)
                           (if v
                               (andmap-cps func-cps (cdr ls) k)
                               (k #f)))))))

;Problem 1-f
(define matrix?-cps
  (lambda (m k)
    (if (not (null? m))
          (if (pair? m)
              (if (not (null? (car m)))
                  (length-cps (car m) (lambda (v)
                                        (matrix?-cps-help (cdr m) v k)))
                  (k #f))
              (k #f))
          (k #f))))
    
(define matrix?-cps-help
  (lambda (m len k)
    (if (null? m)
        (k #t)
        (length-cps (car m) (lambda (v)
                              (if (= len v)
                                  (matrix?-cps-help (cdr m) len k)
                                  (k #f)))))))

(define length-cps
  (lambda (ls k)
    (cond ((null? ls) (k 0))
          (else (length-cps (cdr ls) (lambda (v)
                                       (k (+ 1 v))))))))

(define cps-compose
  (lambda (p1-cps p2-cps)
    (lambda (x k)
      (p2-cps x (lambda (v)
                  (p1-cps v k))))))