tests
testIncludes
	self deny: (char includes: 1.23).
	self assert: (char includes: $a)