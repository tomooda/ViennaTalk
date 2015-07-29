tests
testNil
	self assert: (writer stringify: nil) equals: 'nil'