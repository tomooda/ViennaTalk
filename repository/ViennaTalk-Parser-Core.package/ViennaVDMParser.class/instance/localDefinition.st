parsers-definitions
localDefinition
	^ super localDefinition ==> [ :def | ViennaNode label: 'LocalDefinition' with: def ]