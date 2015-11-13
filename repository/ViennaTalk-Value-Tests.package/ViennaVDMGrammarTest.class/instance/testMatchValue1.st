tests-patterns
testMatchValue1
	self assert: (grammar pattern end parse: '(<quote>)') equals: '<quote>'