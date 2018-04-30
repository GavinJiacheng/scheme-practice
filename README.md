# Scheme-Practice
This is the basical practice for scheme.
This was my SFU's assignment. Please DO NOT copy it if you have the similar assignment.

Here are some examples:
```scheme
> (singleton? '(4 mouse ()))
#f

> (singleton? '(xy))
#t

> (singleton? 4)
#f
```
```scheme
> (my-make-list 3 'a)
(a a a)

> (my-make-list 2 '(1 2 3))
((1 2 3) (1 2 3))

> (my-make-list 2 (my-make-list 3 '(a b)))
(((a b) (a b) (a b)) ((a b) (a b) (a b)))
```

```scheme
> (my-iota 0)
()

> (my-iota 1)
(0)

> (my-iota 2)
(0 1)

> (my-iota 5)
(0 1 2 3 4)
```

```scheme
> (my-length '())
    0

> (my-length '(a))
1

> (my-length '(a (b c) d))
3
```

```scheme
> (nth '(a b c) 0)
a

> (nth '(a b c) 1)
b

> (nth '(a b c) 2)
c

> (nth '(a b c) 3)
;bad index
```

```scheme
> (my-last '(cat))
cat

> (my-last '(cat dog))
dog

> (my-last '(cat dog (1 2 3)))
(1 2 3)

> (my-last '())
my-last: empty list
```

```scheme
> (my-filter odd? '(5 7 0 -6 4))
(5 7)

> (my-filter odd? '(10 5 7 0 11 4))
(5 7 11)

> (my-filter list? '(hat (left right) 4 ()))
((left right) ())

> (my-filter (lambda (x) (or (= x 5) (< x 0))) '(5 6 9 -6 2 5 0 5))
(5 -6 5 5)
```

```scheme
> (my-append '(1 2 3) '(4 5 6 7))
(1 2 3 4 5 6 7)

> (my-append '(1 2 3) '(4))
(1 2 3 4)

> (my-append '() '(4))
(4)
```

```scheme
> (append-all '())
()

> (append-all '((a)))
(a)

> (append-all '((a) (b c)))
(a b c)

> (append-all '((a) (b c) (d)))
(a b c d)

> (append-all '((a) (b c) (d) (e f)))
(a b c d e f)
```

```scheme
> (my-sort '())
()

> (my-sort '(3))
(3)

> (my-sort '(4 1 3 7 5 5 1))
(1 1 3 4 5 5 7)
```

```scheme
> (all-bits 0)
()

> (all-bits 1)
((0) (1))

> (all-bits 2)
((0 0) (0 1) (1 0) (1 1))
```


# Environment
A environment is a data structure that represents variables and their values. 
I used these functions to build an environment:

* Returns a new empty environment:
```scheme
(make-empty-env)
```

* Returns the value of variable v in environment env:
```scheme
(apply-env env v)
```
(If v is not in env, then it calls Scheme’s standard error function to raise a helpful error message.)

* Returns a new environment that is the same as env except that the value of v in it is val.
```scheme
(extend-env v val env)
```
Here is an example:
```scheme
(define test-env
    (extend-env 'a 1
        (extend-env 'b 2
            (extend-env 'c 3
                (extend-env 'b 4
                    (make-empty-env)))))
)

> (apply-env test-env 'a)
1

> (apply-env test-env 'b)
2
```

In the file myeval.scm, I wrote a function called (myeval expr env):
```scheme
(define env1
    (extend-env 'x -1
        (extend-env 'y 4
            (extend-env 'x 1
                (make-empty-env))))
)

> (myeval '(2 + (3 * x))      ;; the expression
          env1                ;; the environment
  )
-1
```

# Expression Simplifier
In the folder Environment build, it has a file simplify.scm which has a function (simplify expr) that returns, if possible, a simplified version of expr. 

here are some examples:

* (0 + e) simplifies to e
* (e + 0) simplifies to e
* (0 * e) simplifies to 0
* (e * 0) simplifies to 0
* (1 * e) simplifies to e
* (e * 1) simplifies to e
* (e / 1) simplifies to e
* (e - 0) simplifies to e
* (e - e) simplifies to 0
* (e ** 0) simplifies to 1
* (e ** 1) simplifies to e
* (1 ** e) simplifies to 1
* if n is a number, then (inc n) simplifies to the value of n + 1
* if n is a number, then (dec n) simplifies to the value of n - 1

And the example code:

```scheme
> (simplify '((1 * (a + 0)) + 0))
;Value: a

> (simplify '(((a + b) - (a + b)) * (1 * (1 + 0))))
;Value: 0
```
