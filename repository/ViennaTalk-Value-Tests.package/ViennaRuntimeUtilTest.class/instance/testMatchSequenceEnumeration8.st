tests-matching-sequence
testMatchSequenceEnumeration8
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2) asOrderedCollection)
		equals: {}