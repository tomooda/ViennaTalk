tests-expressions
testSequenceComprehension4
	self assert: (grammar expression end parse: '[v1|v1,v2 in set s&v3]') isPetitFailure