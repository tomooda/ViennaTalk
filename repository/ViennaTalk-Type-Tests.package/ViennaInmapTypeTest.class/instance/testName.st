tests
testName
	self assert: bool2nat name equals: 'inmap bool to nat'.
	self assert: bool2optbool name equals: 'inmap bool to [bool]'.
	self
		assert: (ViennaInmapType with: ViennaType bool with: ViennaType nat | ViennaType bool) name
		equals: 'inmap bool to (nat|bool)'