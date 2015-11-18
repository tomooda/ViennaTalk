tests-patterns
testPatternList4
	self assert: (grammar patternList end parse: 'p1 , p2 , p3') equals: #('p1' 'p2' 'p3')