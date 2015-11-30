tests
testIncludes
	self assert: (int includes: -1).
	self assert: (int includes: 0).
	self assert: (int includes: 1).
	self deny: (int includes: 1.23).
	self deny: (int includes: $a)