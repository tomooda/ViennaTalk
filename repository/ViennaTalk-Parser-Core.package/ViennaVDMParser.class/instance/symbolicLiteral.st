parsers-literals
symbolicLiteral
	^ super symbolicLiteral flatten
		=>> [ :start :end :string | 
			ViennaNode
				label: 'SymbolicLiteral'
				start: start
				end: end
				with: string trim ]