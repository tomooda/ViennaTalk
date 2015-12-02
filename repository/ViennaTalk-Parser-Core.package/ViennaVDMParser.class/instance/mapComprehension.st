parsers-expressions-basics
mapComprehension
	^ super mapComprehension ==> [ :array | ViennaNode label: 'MapComprehension' withAll: array ]