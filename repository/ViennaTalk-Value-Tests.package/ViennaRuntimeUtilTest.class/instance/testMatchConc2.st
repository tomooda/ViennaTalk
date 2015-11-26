tests-matching-sequence
testMatchConc2
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchSequenceEnumeration: {(ViennaRuntimeUtil matchIdentifier: 'head')})
				conc: (ViennaRuntimeUtil matchIdentifier: 'head')) value: #(1 2 3 4) asOrderedCollection)
		equals: {}