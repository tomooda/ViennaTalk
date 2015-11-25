tests-matching-set
testMatchUnion4
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(1 2 4) asSet)
		equals: {}