parsers-statements
assignmentDefinition
	^ (identifier , colon , type , (colonEq , expression) optional)
		==> [ :quatro | 
			| ident varType initialValue |
			ident := quatro first.
			varType := quatro third.
			initialValue := quatro fourth second.
			{ident.
			varType.
			initialValue} ]