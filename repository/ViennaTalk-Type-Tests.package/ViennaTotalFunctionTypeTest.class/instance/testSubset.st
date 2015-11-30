tests
testSubset
	self assert: nat * nat -> nat <= (nat * nat -> nat).
	self assert: int * nat -> nat <= (nat * nat -> nat).
	self assert: nat * nat -> nat <= (nat * nat -> int).
	self assert: nat * nat +> nat <= (nat * nat -> nat).
	self assert: int * nat +> nat <= (nat * nat -> nat).
	self assert: nat * nat +> nat <= (nat * nat -> int).
	self deny: nat * nat -> nat <= (nat * nat +> nat).
	self deny: int * nat -> nat <= (nat * nat +> nat).
	self deny: nat * nat -> nat <= (nat * nat +> int)