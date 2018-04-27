# Scheme-Practice
This is the basical practice for scheme.
This was my SFU's assignment. Please DO NOT copy it if you have the similar assignment.

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
