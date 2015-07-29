tests
testString3
	self assert: (reader parse: '"\u0061bc"') equals: 'abc'