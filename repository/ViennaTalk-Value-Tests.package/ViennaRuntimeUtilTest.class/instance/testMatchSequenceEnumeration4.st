tests-matching-sequence
testMatchSequenceEnumeration4
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 1) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}