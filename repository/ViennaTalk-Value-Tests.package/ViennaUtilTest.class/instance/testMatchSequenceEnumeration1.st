tests-matching-sequence
testMatchSequenceEnumeration1
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}