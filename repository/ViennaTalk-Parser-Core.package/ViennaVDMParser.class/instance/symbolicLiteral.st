parsers-literals
symbolicLiteral
	^ super symbolicLiteral flatten ==> [ :string | ViennaNode label: 'SymbolicLiteral' with: string trim ]