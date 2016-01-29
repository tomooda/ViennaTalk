parsers-patterns
setEnumPattern
	^ super setEnumPattern ==> [ :array | ViennaNode label: 'SetEnumPattern' withAll: array ]