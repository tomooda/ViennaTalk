tests-matching-sequence
testMatchSequenceEnumeration8
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}) value: #(1 2) asOrderedCollection)
		equals: {}