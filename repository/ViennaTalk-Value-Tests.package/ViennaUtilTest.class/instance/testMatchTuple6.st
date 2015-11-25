tests-matching-tuple
testMatchTuple6
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 3)}) value: #(1 2))
		equals: {}