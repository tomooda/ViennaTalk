parsers-expressions-basics
sequenceComprehension
	^ super sequenceComprehension ==> [ :array | ViennaNode label: 'SequenceComprehension' withAll: array ]