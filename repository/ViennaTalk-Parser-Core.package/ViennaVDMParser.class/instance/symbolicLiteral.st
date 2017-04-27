parsers-literals
symbolicLiteral
	^ super symbolicLiteral  ==> [ :string | ViennaNode label: 'SymbolicLiteral' with: string trim ]