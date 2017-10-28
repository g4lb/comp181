(load "/home/haims/Desktop/pc.scm") 


(define <test> ;; not-followed-by test
	(new  (*parser (range #\0 #\9))
	  (*parser (range #\0 #\9))
	*not-followed-by
         done))
     

	     
(define <SymbolChar>
        (new    (*parser (range #\0 #\9))
                (*parser (range #\a #\z))
                (*parser (range #\A #\Z))
                (*parser (char #\!))
                (*parser (char #\$))
                (*parser (char #\^))
                (*parser (char #\*))
                (*parser (char #\-))
                (*parser (char #\_))
                (*parser (char #\=))
                (*parser (char #\+))
                (*parser (char #\>))
                (*parser (char #\<))
                (*parser (char #\?))
                (*parser (char #\/))
                (*parser (char #\:))
                (*disj 16)
        done))	    

 	     
(define <test-2> ;; stringlitralChar test
	(new  (*parser <SymbolChar>)
		   (*guard (lambda (a)
		       (not(equal? "\\"))))
         done)) 	


(define <test-3> ;; stringlitralChar test
	(new  (*parser <any-char>)
		   (*parser (char #\\))
	*diff
         done))