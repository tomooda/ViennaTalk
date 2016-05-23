tests-expressions
testSequenceComprehension5
	self assert: (grammar expression end parse: '[v1|v1 in seq s&v3]') equals: #('v1' #('v1' 's') 'v3')