tests
testIncludes
	self deny: (nat1 includes: -1).
	self deny: (nat1 includes: 0).
	self assert: (nat1 includes: 1).
	self deny: (nat1 includes: 1.23).
	self deny: (nat1 includes: $a)