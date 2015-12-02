parsers-patterns
setUnionPattern
	^ super setUnionPattern ==> [ :array | ViennaNode label: 'SetUnionPattern' withAll: array ]