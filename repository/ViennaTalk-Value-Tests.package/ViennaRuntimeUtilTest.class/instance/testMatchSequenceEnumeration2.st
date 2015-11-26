tests-matching-sequence
testMatchSequenceEnumeration2
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}