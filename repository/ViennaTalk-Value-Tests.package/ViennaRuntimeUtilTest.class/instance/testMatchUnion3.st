tests-matching-set
testMatchUnion3
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchIdentifier: 'set1')
				union: (ViennaRuntimeUtil matchSetEnumeration: {(ViennaRuntimeUtil matchValue: 3)})) value: #(3) asSet)
		equals: {Dictionary new at: 'set1' put: Set new; yourself}