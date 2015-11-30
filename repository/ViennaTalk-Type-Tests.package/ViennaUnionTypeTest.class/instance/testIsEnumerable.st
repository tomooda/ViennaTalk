tests
testIsEnumerable
	self deny: natBool isEnumerable.
	self assert: quoteBool isEnumerable