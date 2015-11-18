tests-expressions
testSequenceComprehension1
	self assert: (grammar expression end parse: '[v1|v1 in set s&v3]') equals: #('v1' #('v1' 's') 'v3')