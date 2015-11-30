tests
testSubset
	self assert: int <= int.
	self assert: int <= ViennaType real.
	self deny: int <= ViennaType nat