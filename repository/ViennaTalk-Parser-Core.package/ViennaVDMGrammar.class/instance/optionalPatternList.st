parsers-patterns
optionalPatternList
	^ (pattern separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]