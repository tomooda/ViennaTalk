tests
testSubtype
	self assert: bool2optbool <= bool2optbool.
	self deny: bool2optbool <= bool2nat.
	self assert: (ViennaType map: ViennaType bool to: ViennaType bool) <= bool2optbool.
	self deny: bool2optbool <= (ViennaType map: ViennaType bool to: ViennaType bool)