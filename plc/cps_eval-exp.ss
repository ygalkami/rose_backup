(define eval-exp
  (lambda (exp env k)
    (cases expression exp
      (literal-exp (datum)
                   (apply-k k datum))
      (if-exp (test-exp then-exp else-exp)
              (eval-exp test-exp
                        env
                        (testk then-exp else-exp env k)))
      (var-exp (id)
               (apply-env env id k (lookup-fail-continuation id)))
      (lambda-exp (formals body)
                  (apply-k k (closure formals body env)))
      (app-exp (rator rands)
               (eval-exp rator env (rator-k rands env k)))
      
      
(define-datatype continuation continuation?
  (test-k (then-exp expression?)
          (else-exp expression?)
          (env environment?)
          (k continuation?))
  (rator-k (rands (list-of expression?))
           (env environment?)
           (k continuation?))
  (rands-k (proc-value scheme-value?)
           (k continuation?)))

(define apply-k
  (lambda (k v)
    (cases continuation k
      (rator-k (rands env k)
               (eval-rands rands
                           env
                           (rands-k v env k)))
      
               
      
      
(define lookup-fail-continuation
  (lambda (id)
    (lambda ()
      (eopl:erorr "erorr"))))