tests-expressions
testExists1Expression2
	self assert: (grammar expression end parse: 'exists1 v1,v2:t1, v3:t2 & e') isPetitFailure