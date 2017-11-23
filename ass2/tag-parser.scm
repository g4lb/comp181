(load "qq.scm")



(define is-quote-expression?
  (lambda (v)
    (if (and (pair? v) (eq? (car v) 'quote))
      #t
      #f)))
    

(define const-rules
     (lambda(pred)        
                (lambda (exp) (if (pred exp) (list 'const exp) #f))))
               
(define is_boolean (const-rules boolean?))
(define is_character (const-rules char?))
(define is_number (const-rules number?))
(define is_string (const-rules string?))
(define is_vector (const-rules vector?))
(define is_void (const-rules (lambda (x) (equal? (void) x))))

(define is_quote (lambda (exp) (if (is-quote-expression? exp) (list 'const (cadr exp)) #f)))

(define is_const (lambda (sexp)
     (or
          (is_vector sexp)
          (is_boolean sexp)
          (is_character sexp)
          (is_number sexp)
          (is_string sexp)
          (is_quote sexp)
          (is_void sexp)
            )))

(define *reserved-words*
    '(and begin cond define do else if lambda
    let let* letrec or quasiquote unquote
    unquote-splicing quote set!))

(define is_var 
               (lambda (exp) (if (and (symbol? exp) (not (member exp *reserved-words*))) (list 'var exp) #f)))
               
(define (length-list lst)
  (cond ((null? lst) 0)
        (else (+ 1 (length-list (cdr lst))))))

(define is_if
     (lambda (exp) 
          (if (and (eq? (car exp) 'if) (= (length-list exp) 4)) (list  'if3 (parse (cadr exp))
                                                                   (parse (caddr exp)) (parse (cadddr exp)))
            
          (if (and (eq? (car exp) 'if) (= (length-list exp) 3)) (list 'if3 (parse (cadr exp))
                                                                   (parse (caddr exp))(parse (void)))
        #f))))

(define is_or
               (lambda (exp) (if (eq? (car exp) 'or)
               (cond ((null? (cdr exp)) (parse '#f))
                     ((eq? (length (cdr exp)) 1) (parse (car (cdr exp))))
                     (else `(or ,(map parse (cdr exp))))) #f)))
(define is_and
               (lambda (exp) (if (eq? (car exp) 'and)
               (cond ((null? (cdr exp)) (parse '#t))
                     ((eq? (length (cdr exp)) 1) (parse (car (cdr exp))))
                     (else (parse `(if ,(car (cdr exp)) (and ,@(cdr (cdr exp))) #f))))#f)))

(define improper-list-last
        (lambda(l)
            (if (pair? l) (improper-list-last (cdr l)) l)))

(define improper-list-remove-last
        (lambda(l)
            (if (pair? l)
                  (cons (car l) (improper-list-remove-last (cdr l)))
                    '())))

(define remove-duplicates
     (lambda (l)
        (cond ((null? l) '())
            ((member (car l) (cdr l)) (remove-duplicates (cdr l)))
            (else (cons (car l) (remove-duplicates (cdr l)))))))

(define is-distinct
    (lambda (x)
        (equal? (length (remove-duplicates x)) (length x))))

(define is_lambda
               (lambda (exp) (if (eq? (car exp) 'lambda)
                        (let ((params (cadr exp))
                               (bodies (cddr exp)))
                         (if (and (list? params) (not (is-distinct params)))
                            (error 'parse "Repeating lambda params!")
                            (let ((bodies (map parse bodies))
                              (new-params (improper-list-remove-last params))
                              (seq (parse `(begin ,@bodies))))
                                (cond ((list? params) `(lambda-simple ,params ,seq))
                                   ((pair? params) `(lambda-opt ,new-params ,(improper-list-last params) ,seq))
                                   (else `(lambda-opt ,'() ,params ,seq))))))#f)))
(define is_define
               (lambda (exp) (if (eq? (car exp) 'define)
                 (let ((var (cadr exp))
                               (def (cddr exp)))
                  (if (pair? var)
                  (let ((exp (parse `(lambda ,(cdr var) ,@def))))
                    `(,'define ,(parse (car var)) ,exp))
                    (let ((def (parse `(begin ,@def))))
                      `(,'define ,(parse var) ,def))))#f)))


      

(define is_application
               (lambda (exp)
                  (if (null? (car exp))
                     (error 'done (format "Unknown form: ~s" (car exp)))
                     (let ((func (parse (car exp)))
                        (params (map parse (cdr exp))))
                        `(applic ,func ,params)))))


(define is_cond
                (lambda (exp) (if (eq? (car exp) 'cond)
                 (let ((bodies (cdr exp)))
                    (cond ((null? bodies) (error 'parse "Unknown form: (cond)"))
                          ((eq? (caar bodies) 'else) (parse `(begin ,@(cdar bodies))))
                          ((eq? (length bodies) 1) (parse `(if ,(caar bodies) (begin ,@(cdar bodies)))))
                          (else (parse `(if ,(caar bodies) (begin ,@(cdar bodies)) (cond ,@(cdr bodies)))))))#f)))

(define remove-seq
   (lambda (bodies)
       (cond ((null? bodies) bodies)
             ((and (list? (car bodies)) (equal? (caar bodies) 'seq))
                 (append (car (cdar bodies)) (remove-seq (cdr bodies))))
             (else (cons (car bodies) (remove-seq (cdr bodies)))))))


(define is_begin
             (lambda (exp) (if (eq? (car exp) 'begin)
                 (let ((bodies (cdr exp)))
                  (let* ((bodies (map parse bodies))
                         (bodies (remove-seq bodies)))
                    (cond ((null? bodies) (parse (void)))
                         ((eq? (length bodies) 1) (car bodies))
                         (else `(seq ,bodies)))))#f)))


(define is_let
            (lambda (exp) (if (eq? (car exp) 'let)
              (let ((params (cadr exp))
                               (bodies (cddr exp)))
                      (parse `((lambda ,(map car params) ,@bodies)  ,@(map cadr params))))#f)))

(define is_let*
               (lambda (exp) (if (eq? (car exp) 'let*)
                  (let ((params (cadr exp))
                         (bodies (cddr exp)))
                      (cond ((null? params)(parse `(let ,params ,@bodies)))
                            ((eq? (length params) 1) (parse `(let ,params ,@bodies)))
                            (else (parse `(let ,(list (car params)) (let* ,(cdr params) ,@bodies))))))#f)))

(define is_letrec
      (lambda (exp) (if (eq? (car exp) 'letrec)
                  (let ((params (cadr exp))
                         (bodies (cddr exp)))
                    (let ((set-bodies (map (lambda (x y) `(set! ,x ,y))
                                       (map car params) (map cadr params)))
                          (false-params (map (lambda (x y) `(,x #f))
                                           (map car params) (map cadr params)))
                          (let-bodies `((let () ,@bodies))))
                         (parse `(let ,false-params ,@(append set-bodies let-bodies)))))#f)))

(define is_set!
    (lambda (exp) (if (eq? (car exp) 'set!)
                  (let ((arg (cadr exp))
                         (val (caddr exp)))
                 `(set ,(parse arg) ,(parse val)))#f)))

(define is_quasiquote
             (lambda (exp) (if (eq? (car exp) 'quasiquote) (parse (expand-qq (cadr exp))) #f)))
             

            

(define parse (lambda (sexp)
 (or 
     (is_const sexp)
     (is_var sexp)
     (is_cond sexp)
     (is_if sexp)
     (is_or sexp)
     (is_and sexp)
     (is_lambda sexp)
     (is_define sexp)
     (is_begin sexp)
     (is_let sexp)
     (is_let* sexp)
     (is_letrec sexp)
     (is_set! sexp)
     (is_quasiquote sexp)
     (is_application sexp)
     )))
