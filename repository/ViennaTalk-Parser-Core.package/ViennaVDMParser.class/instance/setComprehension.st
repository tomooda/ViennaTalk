parsers-expressions-basics
setComprehension
	^ super setComprehension ==> [ :array | ViennaNode label: 'SetComprehension' withAll: array ]