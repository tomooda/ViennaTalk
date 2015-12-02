parsers-patterns
mapEnumerationPattern
	^ super mapEnumerationPattern ==> [ :array | ViennaNode label: 'MapEnumerationPattern' with: array ]