(define odd?
  (let ([o? 'change-melater]
        [e? 'change-me-later])
    (set! o? (lambda (n) ...))
    (set! e? (lambda (n) ...))
    o?))

(varassign-exp (id exp)
               (set-ref!
                (apply-env-ref env id)
                (eval-exp exp env)))

(define extend-env
  (lambda (vars vals env)
    (extended-env-record vars
                         (map cell vals)
                         env)))

(define apply-env-ref
  (lambda (env sym)
    (cases environment env
      (extended-env-record (syms vals env)
                           (let ([pos ...])
                             (if (number? pos)
                                 (list-ref vals pos)
                                 (apply-env env sym)))))))

(define deref cell-ref)
(define setref! cell-set!)

;pair implementation of cell
(define cell
  (lambda (value)
    (cons 'cell value)))

(define cell-ref cadr)
(define cell-set! set-cadr!)
(define cell? (lambda (x)
                (and (pair? x)
                     (eq? (car x) 'cell))))