tests
testSubtype
	self assert: setofbool <= setofbool.
	self deny: setofbool <= setofnat.
	self assert: setofbool <= (ViennaType setOf: ViennaType bool | ViennaType nat).
	self deny: (ViennaType setOf: ViennaType bool | ViennaType nat) <= setofbool