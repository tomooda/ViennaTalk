tests-matching-set
testMatchUnion2
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(1 2 3 4) asSet)
		equals:
			{(Dictionary new
				at: 'set1' put: #(1 2 4) asSet;
				yourself)}