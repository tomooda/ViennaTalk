tests
testMap2
	self assert: (writer stringify: (Dictionary new at: 1 put: 2; yourself)) equals: '{1|->2}'