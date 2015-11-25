tests-matching-tuple
testMatchTuple5
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: #(1 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}