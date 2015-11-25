tests-matching-sequence
testMatchSequenceEnumeration3
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals: {(Dictionary new)}