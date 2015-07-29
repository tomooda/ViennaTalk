tests
testSet3
	self assert: (ViennaReader new parse: (writer stringify: #(1 2 3) asSet)) equals: #(1 2 3) asSet