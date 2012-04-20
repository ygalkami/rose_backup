;Assignment 4, written by David Pick 3/18/09
;Problem 1
(define relation?
  (lambda (rl)
    (cond ((not (list? rl)) #f)
          ((not (andmap list? rl)) #f)
          ((not (set? rl)) #f)
          ((null? rl) #t)
          ((not (same-length? rl)) #f)
          (else #t))))

(define same-length?
  (lambda (ls)
    (if (equal? (length ls) 1)
        #t
        (if (equal? (length (car ls)) (length (cadr ls)))
            (same-length? (cdr ls))
            #f))))
        
(define set?
  (lambda (set)
    (if (equal? set '())
        #t
        (if (set-contains? set (car set))
            #f
            (set? (cdr set))))))

(define set-contains?
  (lambda (set el)
    (if (equal? (length set) 1)
        #f
        (if (equal? (cadr set) el)
            #t
            (set-contains? (cdr set) el)))))

;Problem 2
(define let->application
  (lambda (ls)
    (let ([vars (firsts (cadr ls))])
    (let ([args (seconds (cadr ls))])
    (append (list (append (list 'lambda vars) (list (caddr ls)))) args)))))

;Problem 3
(define let*->let
  (lambda (ls)
    (if (<= (length ls) 1)
        '()
        (let ([vars (cadr ls)])
        (let ([other (cddr ls)])
          (if (null? other)
              (remove '() (let*-help vars other))
              (let*-help vars other)))))))
        
(define let*-help
  (lambda (vars other)
    (if (null? vars)
        (list 'let '() (car other))
        (if (equal? (length vars) 1)
            (append (list 'let vars) other)
            (append (list 'let (list (car vars))) (list (let*-help (cdr vars) other)))))))
  
;Problem 4
(define filter-in
  (lambda (func ls)
    (if (null? ls)
        '()
        (if (equal? (func (car ls)) #t)
            (cons (car ls) (filter-in func (cdr ls)))
            (filter-in func (cdr ls))))))

;Problem 5
(define filter-out
  (lambda (func ls)
    (if (null? ls)
        '()
        (if (equal? (func (car ls)) #t)
            (filter-out func (cdr ls))
            (cons (car ls) (filter-out func (cdr ls)))))))

;Problem 6
(define edge-count-help
  (lambda (g)
    (if (equal? (length g) 1)
        (length (cadar g))
        (+ (length (cadar g)) (edge-count-help (cdr g))))))
    
(define edge-count
  (lambda (g)
    (if (null? g)
        0
        (/ (edge-count-help g) 2))))

;Prolbem 7
(define remove-vertex
  (lambda (g s)
    (if (null? g)
        g
        (if (equal? (caar g) s)
            (remove-vertex (cdr g) s)
            (cons (remove-el-vertex (car g) s) (remove-vertex (cdr g) s))))))
          
(define firsts
  (lambda (ls)
    (map car ls)))

(define seconds
  (lambda (ls)
    (map cadr ls)))

(define remove-el-vertex
  (lambda (vertex sym)
    (if (equal? (car vertex) sym)
        '()
        (cons (car vertex) (list (remove sym (cadr vertex)))))))
     
(define remove 
  (lambda (element list)
    (cond ((null? list) list)
       ((equal? element (car list)) (cdr list))
       (else (cons (car list) (remove element (cdr list)))))))

;Problem 8
(define graph?
  (lambda (g)
    (if (not (list? g))
        #f
        (if (null? g)
            #t
            (let ([pairs (map2 create-ordered g)])
              (let ([vertices (firsts g)])
                (if (< (length pairs) 2)
                    (cond ((boolean? (car vertices)) #f)
                          ((dups? vertices) #f)
                          ((not-related-el vertices pairs) #f)
                          (else #t))
                    (cond ((boolean? (car vertices)) #f)
                          ((not (list? (car pairs))) #f)
                          ((has-pair (cdr pairs) (car pairs)) #f)
                          ((not (not-nested-list? pairs)) #f)
                          ((has-pair (cdr ls) (reverse (car ls))) #f)
                          ((dups? vertices) #f)
                          ((not-related-el vertices pairs) #f)
                          ((not-related-itself pairs) #f)
                          (else #t)))))))))
  
(define dups?
  (lambda (ls)
    (list? (memv (car ls) (cdr ls)))))

(define not-related-itself
  (lambda (ls)
    (if (null? ls)
        #f
        (if (equal? (caar ls) (cadar ls))
            #t
            (not-related-itself (cdr ls))))))

(define not-related-el
  (lambda (vertices pairs)
    (if (null? pairs)
        #f
        (if (not-related-el-help vertices (car pairs))
            #t
            (not-related-el vertices (cdr pairs))))))

(define not-related-el-help
  (lambda (vertices pair)
    (if (null? vertices)
        #f
        (if (mem (car vertices) pair)
            (not-related-el-help (cdr vertices) pair)
            #t))))
        
(define mem
  (lambda (x ls)
      (cond ((null? ls) #f)
          ((equal? (car ls) x) #t)
          (else (memq x (cdr ls))))))

(define not-nested-list?
  (lambda (ls)
    (if (null? ls)
        #t
        (if (list? (car ls))
            #f
            (not-nested-list? (cdr ls))))))
        
(define create-ordered
  (lambda (ls)
    (let ([el (car ls)])
      (create-ordered-help el (cadr ls)))))

(define create-ordered-help
  (lambda (el ls)
    (if (null? ls)
        '()
        (append (list (list el (car ls))) (create-ordered-help el (cdr ls))))))

(define has-pair
  (lambda (ls el)
    (if (null? ls)
        #f
        (if (equal? (car ls) el)
            #t
            (has-pair (cdr ls) el)))))

(define map2
    (lambda (f ls)
      (if (null? ls)
          '()
          (append (f (car ls))
                (map2 f (cdr ls))))))

(define (add-connections obj)
  (cond [(null? obj) 0]
        [(not (list? obj)) #f]
        [else (+ (length (cadar obj)) (add-connections (cdr obj)))]))

;Problem 9
(define minimize-interval-list
  (lambda (ls)
    (if (null? ls)
        '()
        (if (equal? (length ls) 1)
            ls
            (if (interval-intersects? (car ls) (cadr ls))
                (minimize-interval-list (append (interval-union (car ls) (cadr ls)) (cddr ls)))
                (cons (car ls) (minimize-interval-list (cdr ls))))))))
  
(define interval-union
  (lambda (i1 i2)
    (cond ((interval-intersects? i1 i2) (list (list (min (car i1) (car i2)) (max (car (cdr i1)) (car (cdr i2))))))
          (else (list i1 i2)))))
        
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
