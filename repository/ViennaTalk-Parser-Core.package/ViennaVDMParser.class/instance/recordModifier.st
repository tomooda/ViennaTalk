parsers-expressions-basics
recordModifier
	^ super recordModifier ==> [ :array | ViennaNode label: 'RecordModifier' withAll: array ]