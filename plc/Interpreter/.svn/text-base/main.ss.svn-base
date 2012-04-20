; evaluator for simple expressions.
; Possible starting point for first interpreter assignment.
;                  
; Claude Anderson.  Last modified April, 2009

(load "chez-init.ss") ; Uncomment if you are using Chez Scheme.

(define load-all ; make it easy to reload during debugging
  (lambda ()
    (load "datatypes.ss")
    (load "parse.ss")
    (load "env.ss")
    (load "interpreter.ss")))

(load-all)
;(eval-one-exp '(((lambda (x) (lambda (y) (+ x y))) 1) 2))