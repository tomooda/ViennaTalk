parsers-statements
assignStatement
	^ super assignStatement
		==> [ :pair | 
			| desig expr |
			desig := pair first.
			expr := pair second.
			desig isString
				ifTrue: [ desig , ' := ' , expr ]
				ifFalse: [ 
					| ident path |
					ident := desig first.
					path := desig second.
					ident , ' := ' , ident , ' copyAtPath: {' , (' . ' join: path) , '} put: ' , expr ] ]