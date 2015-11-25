tests-matching-sequence
testMatchSequenceEnumeration6
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 1) asOrderedCollection)
		equals: {}