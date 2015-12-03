parsers-patterns
fieldPatternList
	^ (self fieldPattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]