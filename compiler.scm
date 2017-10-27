(load "/home/galbenevgi/Desktop?
	

(define <Boolean>
	(new
	(*parser (char #\f))
	(*parser (char #\t))
		(*disj 2)
			done))

(define <op>
	(new
	(*parser (char #\+))
	(*parser (char #\-))
		(*disj 2)
			done))