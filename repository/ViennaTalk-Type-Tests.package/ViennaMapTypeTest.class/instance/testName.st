tests
testName
	self assert: bool2nat name equals: 'map bool to nat'.
	self assert: bool2optbool name equals: 'map bool to [bool]'.
	self
		assert: (ViennaMapType with: ViennaType bool with: ViennaType nat | ViennaType bool) name
		equals: 'map bool to (nat|bool)'