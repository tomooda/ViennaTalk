parsers-patterns
bindList
	^ super bindList ==> [ :array | ViennaNode label: 'BindList' with: array ]