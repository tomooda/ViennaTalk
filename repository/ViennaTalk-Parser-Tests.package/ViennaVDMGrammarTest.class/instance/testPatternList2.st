tests-patterns
testPatternList2
	self assert: (grammar patternList end parse: 'p1,p2') equals: #('p1' 'p2')