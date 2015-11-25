tests-matching-sequence
testMatchSequenceEnumeration4
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 1) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}