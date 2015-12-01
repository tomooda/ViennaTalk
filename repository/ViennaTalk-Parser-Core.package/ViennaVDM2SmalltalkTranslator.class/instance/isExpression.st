parsers-type discriminations
isExpression
	^ super isExpression
		==> [ :pair | 
			| typeName expr |
			typeName := pair first.
			expr := pair second.
			(#('bool' 'nat' 'nat1' 'int' 'rat' 'real' 'char' 'token') includes: typeName)
				ifTrue: [ '(ViennaType ' , typeName , ' includes: ' , expr , ')' ]
				ifFalse: [ '(' , typeName , ' includes: ' , expr , ')' ] ]