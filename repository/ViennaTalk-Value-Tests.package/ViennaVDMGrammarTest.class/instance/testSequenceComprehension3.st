tests-expressions
testSequenceComprehension3
	self assert: (grammar expression end parse: '[v1|v1:t&v3]') isPetitFailure