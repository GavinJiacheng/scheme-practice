(define make-empty-env
  (lambda ()
    '()
  )
)

(define (connectval var val env)
    (cons (cons var (getvariable env))
          (cons val (getval env))
    )
)

(define (addframe var frames)
  (cons var frames)
)

(define getvariable
  (lambda (frames)
    (cond
      ((null? frames) '())
      (else (car frames))
    )
  )
)

(define getval
 (lambda(frames)
    (cond
        ((null? frames)
            '()
        )
        (else
            (cdr frames)
        )
     )
  )
)
(define (extend-env v val env)
  (connectval v val env)
)
(define (search var frames)
  (cond
    ((equal? var (car frames)) 1)
    ((null? (cdr frames)) -1)
    (else
        (cond
            ((equal? (search var (cdr frames)) -1)
              -1)
            (else (+ 1
              (search var (cdr frames))
                  )
            )
        )
    )
  )
)
(define (getvalues size frames)
    (cond
        ((= 1 size) (car frames))
        (else (getvalues
                    (- size 1)
                    (cdr frames)
              )
        )
    )
)
(define (apply-env env v)
  (let ((size (search
                  v (getvariable env)
              )
        )
       )
       (cond ((equal? size -1)
               (error "apply-env: empty environment")
              )
              (else (getvalues size (getval env)))
       )

  )
)
