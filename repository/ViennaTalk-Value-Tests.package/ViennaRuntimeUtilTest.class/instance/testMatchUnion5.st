tests-matching-set
testMatchUnion5
	self
		assert:
			((ViennaRuntimeUtil match: (ViennaRuntimeUtil matchIdentifier: 'set1') union: (ViennaRuntimeUtil matchIdentifier: 'set2')) value: #() asSet)
		equals: {}