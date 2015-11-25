tests-matching-tuple
testMatchTuple4
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field1').
					(ViennaUtil matchIdentifier: 'field2')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}