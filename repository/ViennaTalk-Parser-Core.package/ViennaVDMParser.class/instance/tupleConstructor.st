parsers-expressions-basics
tupleConstructor
	^ super tupleConstructor ==> [ :array | ViennaNode label: 'TupleConstructor' with: (ViennaNode label: 'ExpressionList' withAll: array) ]