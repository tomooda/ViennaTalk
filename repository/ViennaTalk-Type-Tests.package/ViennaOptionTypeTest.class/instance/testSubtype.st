tests
testSubtype
	self assert: optionNat <= optionNat.
	self deny: optionNat <= optionQuote.
	self assert: ViennaType nat <= optionNat.
	self deny: optionNat <= ViennaType nat