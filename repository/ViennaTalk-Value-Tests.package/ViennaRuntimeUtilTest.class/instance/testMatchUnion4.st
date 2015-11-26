tests-matching-set
testMatchUnion4
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchIdentifier: 'set1')
				union: (ViennaRuntimeUtil matchSetEnumeration: {(ViennaRuntimeUtil matchValue: 3)})) value: #(1 2 4) asSet)
		equals: {}