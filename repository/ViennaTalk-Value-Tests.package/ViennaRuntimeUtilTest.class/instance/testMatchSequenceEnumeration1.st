tests-matching-sequence
testMatchSequenceEnumeration1
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}