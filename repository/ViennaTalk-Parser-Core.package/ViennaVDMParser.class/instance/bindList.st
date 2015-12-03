parsers-patterns
bindList
	^ super bindList ==> [ :array | ViennaNode label: 'BindList' withAll: array ]