parsers-statements
assignmentDefinition
	^ super assignmentDefinition
		==> [ :triple | 
			| ident value |
			ident := triple first.
			value := triple third.
			{{ident}.
			(value ifNil: [ '' ] ifNotNil: [ ident , ' := ' , value ])} ]