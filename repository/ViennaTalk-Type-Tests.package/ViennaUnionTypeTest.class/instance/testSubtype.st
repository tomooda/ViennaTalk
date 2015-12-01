tests
testSubtype
	self assert: natBool <= natBool.
	self assert: ViennaType nat <= natBool.
	self assert: ViennaType bool <= natBool.
	self deny: natBool <= ViennaType nat.
	self deny: natBool <= ViennaType bool