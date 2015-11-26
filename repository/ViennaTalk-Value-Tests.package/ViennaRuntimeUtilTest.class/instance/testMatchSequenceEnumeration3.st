tests-matching-sequence
testMatchSequenceEnumeration3
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals: {(Dictionary new)}