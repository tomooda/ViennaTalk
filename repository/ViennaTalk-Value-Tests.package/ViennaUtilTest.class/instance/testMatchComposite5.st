tests-matching-composite
testMatchComposite5
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}