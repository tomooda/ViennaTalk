tests-expressions
testSubsequence1
	self assert: (grammar expression end parse: 's(i1,...,i2)') equals: #('s' 'i1' 'i2')