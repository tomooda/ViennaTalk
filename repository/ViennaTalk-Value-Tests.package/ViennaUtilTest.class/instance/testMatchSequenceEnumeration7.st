tests-matching-sequence
testMatchSequenceEnumeration7
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2 3) asOrderedCollection)
		equals: {}