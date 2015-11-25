tests-matching-sequence
testMatchConc1
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchSequenceEnumeration: {(ViennaUtil matchIdentifier: 'head')})
				conc: (ViennaUtil matchIdentifier: 'tail')) value: #(1 2 3 4) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'head' put: 1;
				at: 'tail' put: #(2 3 4) asOrderedCollection;
				yourself)}