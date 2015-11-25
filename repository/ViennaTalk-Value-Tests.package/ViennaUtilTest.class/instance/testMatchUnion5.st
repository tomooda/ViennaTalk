tests-matching-set
testMatchUnion5
	self
		assert:
			((ViennaUtil match: (ViennaUtil matchIdentifier: 'set1') union: (ViennaUtil matchIdentifier: 'set2')) value: #() asSet)
		equals: {}