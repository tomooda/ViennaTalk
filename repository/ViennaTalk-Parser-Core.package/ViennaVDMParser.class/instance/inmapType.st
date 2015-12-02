parsers-types
inmapType
	^ super inmapType ==> [ :array | ViennaNode label: 'InmapType' withAll: array ]