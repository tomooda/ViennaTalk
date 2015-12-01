tests
testSubtype
	self assert: seqofnat <= seqofnat.
	self assert: seqofnat <= (ViennaType seqOf: ViennaType nat | ViennaType bool).
	self deny: (ViennaType seqOf: ViennaType bool | ViennaType nat) <= seqofnat