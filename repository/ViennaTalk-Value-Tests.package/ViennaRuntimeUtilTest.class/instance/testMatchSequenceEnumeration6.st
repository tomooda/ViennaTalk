tests-matching-sequence
testMatchSequenceEnumeration6
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 1) asOrderedCollection)
		equals: {}