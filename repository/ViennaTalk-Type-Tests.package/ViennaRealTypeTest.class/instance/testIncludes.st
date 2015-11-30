tests
testIncludes
	self assert: (real includes: -1).
	self assert: (real includes: 0).
	self assert: (real includes: 1).
	self assert: (real includes: 1.23).
	self deny: (real includes: $a)