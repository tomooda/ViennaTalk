parsers-definitions
localDefinitionList
	^ super localDefinitionList ==> [ :array | ViennaNode label: 'LocalDefinitionList' withAll: array ]