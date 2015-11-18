tests-expressions
testSequenceEnumeration3
	self assert: (grammar expression end parse: '[e1,e2]') equals: #('e1' 'e2')