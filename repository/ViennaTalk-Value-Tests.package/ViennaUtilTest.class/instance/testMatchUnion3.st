tests-matching-set
testMatchUnion3
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(3) asSet)
		equals: {}