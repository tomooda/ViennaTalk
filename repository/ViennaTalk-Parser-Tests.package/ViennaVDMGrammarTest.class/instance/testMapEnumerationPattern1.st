tests-patterns
testMapEnumerationPattern1
	self assert: (grammar pattern end parse: '{|->}') equals: #().
	self assert: (grammar pattern end parse: '{ |-> }') equals: #()