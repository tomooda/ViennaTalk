as yet unclassified
testSubtype
	self assert: set1ofbool <= set1ofbool.
	self deny: set1ofbool <= set1ofnat.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool | ViennaType nat).
	self deny: (ViennaType setOf: ViennaType bool | ViennaType nat) <= set1ofbool.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool).
	self deny: (ViennaType setOf: ViennaType bool) <= set1ofbool