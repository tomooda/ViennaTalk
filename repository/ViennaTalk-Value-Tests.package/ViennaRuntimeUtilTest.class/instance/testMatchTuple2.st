tests-matching-tuple
testMatchTuple2
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}