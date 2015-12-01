tests
testSubtype
	self assert: nat * nat -> nat <= (nat * nat -> nat).
	self assert: int * nat -> nat <= (nat * nat -> nat).
	self assert: nat * nat -> nat <= (nat * nat -> int)