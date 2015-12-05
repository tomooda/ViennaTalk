parsers-statements
whileLoop
	^ super whileLoop
		==> [ :pair | 
			| cond body |
			cond := pair first.
			body := pair second.
			'[' , cond , '] whileTrue: [' , body , ']' ]