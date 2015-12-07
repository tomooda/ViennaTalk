parsers-types
stateFieldList
	^ super stateFieldList ==> [ :array | ViennaNode label: 'FieldList' withAll: array ]