parsers-interfaces
valueSignature
	^ super valueSignature ==> [ :array | ViennaNode label: 'ValueSignature' withAll: array ]