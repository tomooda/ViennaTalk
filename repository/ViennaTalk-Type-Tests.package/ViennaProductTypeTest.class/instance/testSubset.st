tests
testSubset
	self assert: natBool <= natBool.
	self deny: natBool <= quoteBool.
	self deny: ViennaType nat <= natBool