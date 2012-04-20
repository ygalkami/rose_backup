(define compose
  (lambda first
    (lambda (x)
      (if (null? first)
          x
          ((car first) ((apply compose (cdr first)) x))))))