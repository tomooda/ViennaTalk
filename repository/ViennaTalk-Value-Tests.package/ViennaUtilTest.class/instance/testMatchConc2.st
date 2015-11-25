tests-matching-sequence
testMatchConc2
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchSequenceEnumeration: {(ViennaUtil matchIdentifier: 'head')})
				conc: (ViennaUtil matchIdentifier: 'head')) value: #(1 2 3 4) asOrderedCollection)
		equals: {}