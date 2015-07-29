tests
testTuple3
	self assert: (writer stringify: #(1 2 3)) equals: 'mk_(1,2,3)'