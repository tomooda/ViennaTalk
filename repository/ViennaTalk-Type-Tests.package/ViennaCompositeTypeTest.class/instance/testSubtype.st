tests
testSubtype
	self assert: composite <= composite.
	self deny: composite <= ViennaType int