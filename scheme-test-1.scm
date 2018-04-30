(define singleton?
    (lambda (x)
        (cond
	    ((not(list? x)) #f)
            ((null? x) #f)             ;; base case
            ((null?  (cdr x)) #t)  ;; recursive case
	          (else #f)
        )
    )
)




(define my-make-list
    (lambda (n x)
      (cond
        ((= n 0) '())
        (else (cons x 
		    (my-make-list  (- n 1) x)))
        )
      )
    )



  (define my-iota
  (lambda (n)
    (cond
      ((= n 0) '())
      ((= n 1) '(0))
      (else  ( my-append  
			(my-iota (- n 1)) 
			(cons (- n 1) '()) 
	     )
       )
     )
   )
 )



  (define my-len
    (lambda (lst)
        (cond
            ((null? lst)
                0)
            ((not (list? lst))
                1)
            (else
                (+ 1
                       (my-len (cdr lst)))
            )
        )
    )
)



(define nth
    (lambda (lst i)
      (cond
        ((= i 0) (car lst))
        (else (nth (cdr lst) (- i 1)))
       )
     )
   )





(define my-last
  (lambda (lst)
    (cond
      ((not(list? lst)) lst)
      ((null? lst) (error "my-last: empty list"))
      ((null? (cdr lst))  
      			(car lst)
       )
      (else    (my-last(cdr lst)))
     )
  )
)



(define my-filter
    (lambda (pred? lst)
        (cond
            ((null? lst)
                '())
            ((pred? (car lst))
                (cons (car lst) (my-filter pred? (cdr lst))))
            (else
                (my-filter pred? (cdr lst)))
        )
    )
)


(define my-append
(lambda(A B)
  (cond
    ((null? A) B)
    ((not(list? A)) (cons A B))
    (else (cons (car A) (my-append (cdr A) B)))
   )
 )
)


(define append-all
    (lambda (lol)
        (cond
            ((null? lol)  lol)
            ((not (list? lol)) lol)
            ((list? (car lol)) (my-append  (append-all (car lol)) (append-all (cdr lol))))
            (else (cons (car lol) (append-all (cdr lol))))
        )
    )
)


(define mergesort
   (lambda (l1 l2)
     (cond
        ((null? l1) l2)
        ((null? l2) l1)
        ( (< (car l1) (car l2))
                 (cons (car l1) (mergesort (cdr l1) l2) ) )
        (else
                 (cons (car l2) (mergesort (cdr l2) l1))
        )
      )
    )
 )

(define evenposition
   (lambda (lst)
     (cond
     	((null? lst) '())
     	((null? (cdr lst)) '())
     	(else (cons (car (cdr lst)) 
		    (evenposition (cdr (cdr lst)))
	      )
	)
     )
   )
)

(define oddposition
   (lambda (lst)
     (cond
    	 ((null? lst) '())
    	 ((null? (cdr lst)) (list (car lst)))
    	 (else       (cons (car lst) (oddposition (cdr (cdr lst)))))
     )
   )
)

 (define my-sort
   (lambda (lst)
     (cond
      ((null? lst) lst)
      ((null? (cdr lst)) lst)
      (else    (mergesort
               (my-sort (oddposition lst))
               (my-sort (evenposition lst))))
     )
   )
)




(define all-bits
  (lambda (n)
    (check-length 	
	(number-to-list 	
		(make-list 0 
			(get-tenpower n)
		)
	) 
     n)
   )
)

(define get-tenpower
  (lambda (n)
    (cond
      ((= n 1) 1)
      (else (* (get-tenpower (- n 1)) 10))
    )
  )
)

(define make-list
  (lambda (n tenpower)
    (cond
      ((not(< tenpower 1)) 
		(my-append 
			(make-list n (/ tenpower 10))  		
			(make-list (+ n tenpower) (/ tenpower 10))
		)
	)
      (else (cons n '()))
    )
  )
)

(define number-to-list
  (lambda (lst)
    (cond
      ((null? (cdr lst)) (cons (trans(car lst) '())'()))
      (else 
		(my-append 
			( cons (trans (car lst) '()) '())   
			 (number-to-list (cdr lst))
		)
	)
    )
  )
)



(define trans
 (lambda (num lst)
  (cond
    ((< num 10) (cons num lst))
    (else (trans  (floor (/ num 10)) 
	  (cons (modulo num 10) lst)))
    )
  )
)

(define check-length
  (lambda (lst dig)
    (cond
      ((null? lst)  '())
      ((< (my-len (car lst)) dig) 
		(my-append 
			( cons   (add-len (car lst) (- dig (my-len (car lst)))) 
				 '()
			)  
			(check-length (cdr lst) dig)
		)
      )
      (else (my-append (cons (car lst) '() )(check-length (cdr lst) dig) ))
    )
  )
)

(define add-len
  (lambda (lst diff)
    (cond
      ((= diff 0) lst)
      (else (cons 0 (add-len lst (- diff 1))))
    )
  )
)
