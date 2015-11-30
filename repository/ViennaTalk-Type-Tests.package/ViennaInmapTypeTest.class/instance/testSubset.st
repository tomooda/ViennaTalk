tests
testSubset
	self assert: bool2optbool <= bool2optbool.
	self deny: bool2optbool <= bool2nat.
	self assert: (ViennaType inmap: ViennaType bool to: ViennaType bool) <= bool2optbool.
	self deny: bool2optbool <= (ViennaType inmap: ViennaType bool to: ViennaType bool).
	self assert: bool2optbool <= (ViennaType map: bool2optbool keytype to: bool2optbool valuetype).
	self deny: bool2optbool >= (ViennaType map: bool2optbool keytype to: bool2optbool valuetype)