parsers-literals
symbolicLiteral
	^ super symbolicLiteral
		==> [ :string | 
			ViennaNode
				label: 'SymbolicLiteral'
				with:
					(string isString
						ifTrue: [ string ]
						ifFalse: [ string printString ]) ]