parsers-types
mapType
	^ super mapType ==> [ :array | ViennaNode label: 'MapType' withAll: array ]