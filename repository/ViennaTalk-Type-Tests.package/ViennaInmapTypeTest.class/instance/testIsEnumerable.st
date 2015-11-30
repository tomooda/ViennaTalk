tests
testIsEnumerable
	self deny: bool2nat isEnumerable.
	self assert: bool2optbool isEnumerable