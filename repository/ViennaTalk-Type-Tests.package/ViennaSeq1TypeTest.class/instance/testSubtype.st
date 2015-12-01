tests
testSubtype
	self assert: seq1ofnat <= seq1ofnat.
	self assert: seq1ofnat < (ViennaType seqOf: ViennaType nat).
	self assert: seq1ofnat <= (ViennaType seqOf: ViennaType nat).
	self deny: (ViennaType seqOf: ViennaType nat) <= seq1ofnat