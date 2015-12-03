parsers-definitions
program
	^ super program
		==> [ :array | 
			| doc expr |
			doc := array first.
			expr := array second.
			(doc , expr) ==> [ :pair | pair first , pair second ] ]