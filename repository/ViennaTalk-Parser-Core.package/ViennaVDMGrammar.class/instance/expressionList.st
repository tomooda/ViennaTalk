parsers-expressions-basics
expressionList
	^ (expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]