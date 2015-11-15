tests-expressions
testSequenceComprehension2
	self assert: (grammar expression end parse: '[v1|v1 in set s]') equals: #('v1' #('v1' 's') nil)