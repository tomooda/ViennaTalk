tests-types
testSetType2
	self assert: (grammar type end parse: 'set of set of t') equals: 't'