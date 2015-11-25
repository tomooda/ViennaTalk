tests-matching-tuple
testMatchTuple1
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}