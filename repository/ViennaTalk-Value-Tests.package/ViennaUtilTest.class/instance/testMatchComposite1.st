tests-matching-composite
testMatchComposite1
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}