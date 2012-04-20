; Environment defionitions for CSSE 304 Scheme interpreter.  Based on EoPL section 2.3

(define empty-env
  (lambda ()
    (empty-env-record)))

(define extend-env
  (lambda (syms vals env)
    (extended-env-record syms (map create-cell vals) env)))

(define list-find-position
  (lambda (sym los)
    (list-index (lambda (xsym) (eqv? sym xsym)) los)))

(define list-index
  (lambda (pred ls)
    (cond
     ((null? ls) #f)
     ((pred (car ls)) 0)
     (else (let ((list-index-r (list-index pred (cdr ls))))
	     (if (number? list-index-r)
		 (+ 1 list-index-r)
		 #f))))))

(define apply-env
  (lambda (env1 env2 sym succeed fail) ; succeed and fail are procedures applied if the var is or isn't found, respectively.
    (cases environment env1
      (empty-env-record ()
        (cases environment env2
          (empty-env-record ()
                            (fail))
          (extended-env-record (syms vals ext-env)
                               (apply-env env2 (empty-env) sym succeed fail))))
      (extended-env-record (syms vals ext-env)
                           (let ((pos2 (list-find-position sym syms)))
                             (if (number? pos2)
                                 (let ((return (list-ref vals pos2)))
                                   (if (symbol? (car return))
                                       (apply-env ext-env env2 (car return) succeed fail)
                                       (succeed return)))
                                 (apply-env ext-env env2 sym succeed fail)))))))

(define create-cell
  (lambda (val)
    (cons val (cell))))

(define cell-value
  (lambda (c)
    (car c)))