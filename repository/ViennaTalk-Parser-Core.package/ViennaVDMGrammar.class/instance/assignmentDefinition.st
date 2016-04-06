parsers-statements
assignmentDefinition
	^ ((self decl: identifier) trim , colon , type , (colonEq , expression) optional)
		==> [ :quatro | 
			| ident varType initialValue |
			ident := quatro first.
			varType := quatro third.
			initialValue := quatro fourth ifNotNil: #second.
			{ident.
			varType.
			initialValue} ]