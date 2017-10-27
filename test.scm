(load "/home/galbenevgi/Desktop/comp181/pc.scm")

(define <op>
	(new
	(*parser (char #\+))
	(*parser (char #\-))
		(*disj 2)
			done))