tests-patterns
testMapEnumerationPattern3
	self assert: (grammar pattern end parse: '{a|->b,c|->d}') equals: #(#('a' 'b') #('c' 'd')).
	self assert: (grammar pattern end parse: '{ a |-> b , c |-> d }') equals: #(#('a' 'b') #('c' 'd'))