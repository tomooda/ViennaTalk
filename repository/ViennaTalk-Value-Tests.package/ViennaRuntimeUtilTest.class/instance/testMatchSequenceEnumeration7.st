tests-matching-sequence
testMatchSequenceEnumeration7
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2 3) asOrderedCollection)
		equals: {}