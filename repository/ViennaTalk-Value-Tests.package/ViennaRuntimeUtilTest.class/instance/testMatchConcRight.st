tests-matching-sequence
testMatchConcRight
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchSequenceEnumeration: {(ViennaRuntimeUtil matchIdentifier: 'head')})
				conc: (ViennaRuntimeUtil matchIdentifier: 'tail')
				right: 3) value: #(1 2 3 4) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'head' put: 1;
				at: 'tail' put: #(2 3 4) asOrderedCollection;
				yourself)}