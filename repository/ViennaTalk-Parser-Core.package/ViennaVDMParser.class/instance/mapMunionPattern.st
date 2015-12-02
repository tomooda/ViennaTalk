parsers-patterns
mapMunionPattern
	^ super mapMunionPattern ==> [ :array | ViennaNode label: 'MapMunionPattern' withAll: array ]