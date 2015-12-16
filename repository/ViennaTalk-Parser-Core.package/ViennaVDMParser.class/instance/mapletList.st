parsers-expressions-basics
mapletList
	^ super mapletList ==> [ :array | ViennaNode label: 'MapletList' withAll: array ]