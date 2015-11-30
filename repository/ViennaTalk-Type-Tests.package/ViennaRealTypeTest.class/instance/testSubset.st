tests
testSubset
	self assert: real <= real.
	self deny: real < ViennaType int.
	self deny: real < ViennaType nat.
	self deny: real < ViennaType nat1