tests
testTuple1
	self assert: (reader parse: 'mk_(1, 2)') equals: #(1 2)