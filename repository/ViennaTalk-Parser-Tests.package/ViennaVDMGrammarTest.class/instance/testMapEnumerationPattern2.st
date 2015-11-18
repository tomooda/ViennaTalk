tests-patterns
testMapEnumerationPattern2
	self assert: (grammar pattern end parse: '{a|->b}') equals: #(#('a' 'b')).
	self assert: (grammar pattern end parse: '{ a |-> b }') equals: #(#('a' 'b'))