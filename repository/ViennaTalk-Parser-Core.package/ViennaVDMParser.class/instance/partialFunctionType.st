parsers-types
partialFunctionType
	^ super partialFunctionType ==> [ :array | ViennaNode label: 'PartialFunctionType' withAll: array ]