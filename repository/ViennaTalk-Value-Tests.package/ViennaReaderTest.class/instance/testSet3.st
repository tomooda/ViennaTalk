tests
testSet3
	self assert: (reader parse: '{1,2,3}') equals: #(1 2 3) asSet