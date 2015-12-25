parsers-definitions
equalDefinitionList
	^ super equalDefinitionList ==> [ :array | ViennaNode label: 'EqualDefinitionList' withAll: array ]