parsers-literals
booleanLiteral
	^ super booleanLiteral
		==> [ :b | 
			b
				ifTrue: [ 'true' ]
				ifFalse: [ 'false' ] ]