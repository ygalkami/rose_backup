;Assignment 5, written by David Pick
;Problem 1
(define exists?
  (lambda (pred lst)
    (if (null? lst)
        #f
        (if (pred (car lst))
            #t
            (exists? pred (cdr lst))))))

;Problem 2
(define vector-index
  (lambda (pred vector)
    (if (eq? (vector-length vector) 0)
        #f
        (vector-index-help pred (vector->list vector) 0))))
     
(define vector-index-help
  (lambda (pred vector index)
    (if (null? vector)
        #f
        (if (pred (car vector))
            index
            (vector-index-help pred (cdr vector) (+ index 1))))))
  
;Problem 3
(define product
  (lambda (ls1 ls2)
    (if (null? ls1)
        '()
        (append (cross-list (car ls1) ls2) (product (cdr ls1) ls2)))))
    
(define cross-list
  (lambda (el ls)
    (if (null? ls)
        '()
        (cons (list el (car ls)) (cross-list el (cdr ls))))))

;Problem 4
(define vector-append-list
  (lambda (vector ls)
    (if (eq? (vector-length vector) 0)
        `#(,@ls)
        (vector-append-list-help vector ls (- (vector-length vector) 1)))))

(define vector-append-list-help
  (lambda (vector ls num)
    (if (eq? num -1)
        `#(,@ls)
        (vector-append-list-help vector (cons (vector-ref vector num) ls) (- num 1)))))

;Problem 5
(define rotate
  (lambda (ls)
    (if (or (null? ls) (eq? (length ls) 1))
        ls
        (cons (list-ref ls (- (length ls) 1)) (remove (list-ref ls (- (length ls) 1)) ls)))))
         
(define remove 
  (lambda (element list)
    (cond ((null? list) list)
       ((equal? element (car list)) (cdr list))
       (else (cons (car list) (remove element (cdr list)))))))

;Problem 6
(define flatten
  (lambda (ls)
    (if (exists? list? ls)
        (flatten-help ls)
        ls)))

(define flatten-help
  (lambda (ls)
    (if (exists? list? ls)
        (cond ((null? (car ls)) (flatten-help (remove (car ls) ls)))
              ((and (list? (car ls)) (eq? (length (car ls)) 1)) (flatten-help (cons (caar ls) (remove (car ls) ls))))
              ((list? (car ls)) (flatten-help (append (remove-elements-from-list (car ls)) (cdr ls))))
              (else (cons (car ls) (flatten-help (cdr ls)))))
        ls)))

(define remove-elements-from-list
  (lambda (ls)
    (if (null? ls)
        '()
        (cons (list (car ls)) (remove-elements-from-list (cdr ls))))))

;Problem 7
(define merge
  (lambda (ls1 ls2)
    (if (null? ls1)
        ls2
        (insert (car ls1) (merge ls2 (cdr ls1))))))

(define insert
  (lambda (el ls)
    (if (null? ls)
        (list el)
        (if (< el (car ls))
            (cons el ls)
            (cons (car ls) (insert el (cdr ls)))))))

;Problem 8
(define path
  (lambda (n bst)
    (cond ((eq? n (car bst)) '())
          ((null? (car bst)) #f)
          ((> n (car bst)) (cons 'right (path n (caddr bst))))
          ((< n (car bst)) (cons 'left (path n (cadr bst))))
          (else #f))))

;Problem 9
(define qsort
  (lambda (func ls)
    (if (<= (length ls) 1)
        ls
        (append (append (qsort func (qsort-less func (cdr ls) (car ls))) (list (car ls)))
                (qsort func (qsort-greater func (cdr ls) (car ls)))))))

(define qsort-greater
  (lambda (func ls pivot)
    (if (null? ls)
        '()
        (if (func pivot (car ls))
            (cons (car ls) (qsort-greater func (cdr ls) pivot))
            (qsort-greater func (cdr ls) pivot)))))

(define qsort-less
  (lambda (func ls pivot)
    (if (null? ls)
        '()
        (if (func pivot (car ls))
            (qsort-less func (cdr ls) pivot)
            (cons (car ls) (qsort-less func (cdr ls) pivot))))))

;Problem 10
(define connected?
  (lambda (g)
    (let ([n (length g)])
      (let ([pairs (map2 create-ordered g)])
        (let ([vertices (firsts g)])
        (cond ((< (length g) 2) #t)
              ((null? pairs) #f)
              ((null? (remove-list vertices (flatten (related-nodes (list (car pairs)) pairs)))) #t)
              (else #f)))))))

(define remove-duplicates
  (lambda (lst)
    (if (null? lst) '()
        (let ((first (car lst))
              (rest (remove-duplicates (cdr lst))))
          (if (member first rest) rest
              (cons first rest))))))

(define related-nodes
  (lambda (node-ls ls)
    (let ([related (remove-duplicates (related-nodes-help2 node-ls ls))])
    (if (eq? (length related) (length node-ls))
        related
        (related-nodes related ls)))))

(define related-nodes-help2
  (lambda (node-ls ls)
    (if (null? node-ls)
        '()
        (append (related-nodes-help (car node-ls) ls) (related-nodes-help2 (cdr node-ls) ls)))))

(define related-nodes-help
  (lambda (node ls)
    (if (null? ls)
        '()
        (if (or (eq? (cadr node) (caar ls)) (eq? (car node) (caar ls)) (eq? (cadr node) (cadar ls)) (eq? (car node) (cadar ls)))
            (append (list (car ls)) (related-nodes-help node (cdr ls)))
            (related-nodes-help node (cdr ls))))))

(define create-ordered
  (lambda (ls)
    (let ([el (car ls)])
      (create-ordered-help el (cadr ls)))))

(define create-ordered-help
  (lambda (el ls)
    (if (null? ls)
        '()
        (append (list (list el (car ls))) (create-ordered-help el (cdr ls))))))

(define map2
    (lambda (f ls)
      (if (null? ls)
          '()
          (append (f (car ls))
                (map2 f (cdr ls))))))

(define firsts
  (lambda (ls)
    (map car ls)))

(define remove-list
  (lambda (ls1 ls2)
    (if (null? ls2)
        ls1
        (remove-list (remove (car ls2) ls1) (cdr ls2)))))