parsers-patterns
mapletPattern
	^ super mapletPattern ==> [ :array | ViennaNode label: 'MapletPattern' withAll: array ]