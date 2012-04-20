(define eval-exp
  (lambda (exp env)
    (cases expression exp
      (lit-exp (datum) datum)
      (var-exp (id)
               (apply-env env id
                          (lambda (x) x)
                          (lambda ()
                            (apply-env global-env id
                                       (lambda (x) x)
                                       (lambda ()
                                         (eopl:error "bad stuff ~a"))))))
      (app-exp (rator rands)
               (let ((proc-value (eval-exp rator env))
                     (args (eval-rands rands env)))
                 (apply-proc proc-value args)))
      (else (eopl:error 'eval-exp
                        "Bad abstract syntax: ~a"
                        exp)))))

(define eval-rands (lambda (rands env)
                     (map (lambda (e) eval-exp e env))))

(let-exp (vars exps bodies)
         (let loop ((bodies bodies))
           (let ((first (eval-exp (car bodies) new-env)))
             (if (null? (cdr bodies))
                 (loop (cdr bodies))))))

(if-exp (test then else)
        (if (eval-exp test env)
            (eval-exp then env)
            (eval-exp else env)))

