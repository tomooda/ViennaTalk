tests-matching-sequence
testMatchSequenceEnumeration2
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}