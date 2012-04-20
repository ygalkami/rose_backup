; Datatype for procedures.  At first there is only one
; kind of procedure, but more kinds will be added later.

(define-datatype proc-val proc-val?
  [prim-proc
   (name symbol?)]
  [closure
   (ids (lambda (x) (or (pair? x)
                        (null? x)
                        (symbol? x))))
   (body (list-of expression?))
   (env environment?)])

;; Parsed expression datatypes

(define-datatype expression expression?
  [var-exp        ; variable references
   (id symbol?)]
  [lit-exp        ; "Normal" data.  Did I leave out any types?
   (datum
    (lambda (x)
      (or (number? x)
          (vector? x)
          (boolean? x)
          (symbol? x)
          (string? x)
          (null? x)
          (pair? x))))]
  [lambda-exp
    (id (lambda (x) (or (symbol? x) (pair? x) (null? x))))
    (body (list-of expression?))]
  [app-exp        ; applications
   (rator expression?)
   (rands (list-of expression?))]
  [while-exp
   (test expression?)
   (body (list-of expression?))]
  [if-exp
   (test-exp expression?)
   (true-exp expression?)
   (false-exp expression?)]
  [let-exp
   (kind symbol?)
   (symbols (list-of symbol?))
   (values (list-of expression?))
   (body (list-of expression?))]
  [named-let-exp
   (name symbol?)
   (symbols (list-of symbol?))
   (values (list-of expression?))
   (body (list-of expression?))]
  [if-2-exp
   (test-exp expression?)
   (true-exp expression?)]
  [quote-exp
   (arg scheme-value?)]
  [begin-exp
   (bodies (list-of expression?))]
  [cond-exp
   (conds (list-of expression?))
   (bodies (list-of expression?))]
  [case-exp
   (test (lambda (x) (or (symbol? x) (number? x) (pair? x))))
   (lists (list-of (lambda (x) (or (symbol? x) (number? x) (pair? x)))))
   (bodies (list-of expression?))]
  [and-exp
   (bodies (list-of expression?))]
  [or-exp
   (bodies (list-of expression?))]
  [set!-exp
   (var symbol?)
   (exp expression?)]
  [define-exp
    (var symbol?)
    (exp expression?)])

;; environment type definitions

(define scheme-value?
  (lambda (x) #t))

(define-datatype environment environment?
  (empty-env-record)
  (extended-env-record
   (syms (list-of symbol?))
   (vals (list-of cell?))
   (env environment?)))

(define-datatype cell-datatype cell-datatype?
  (cell))

(define cell?
  (lambda (x)
    (and (pair? x)
         (cell-datatype? (cdr x)))))