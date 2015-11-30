tests
testIncludes
	self deny: (nat includes: -1).
	self assert: (nat includes: 0).
	self assert: (nat includes: 1).
	self deny: (nat includes: 1.23).
	self deny: (nat includes: $a)