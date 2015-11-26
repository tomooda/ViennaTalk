tests-matching-tuple
testMatchTuple5
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: #(1 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}