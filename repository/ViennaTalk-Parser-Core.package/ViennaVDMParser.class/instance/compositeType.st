parsers-types
compositeType
	^ super compositeType ==> [ :array | ViennaNode label: 'CompositeType' withAll: array ]