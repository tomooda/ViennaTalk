tests-expressions
testSetEnumeration2
	self assert: (grammar expression end parse: '{e1}') equals: #('e1')