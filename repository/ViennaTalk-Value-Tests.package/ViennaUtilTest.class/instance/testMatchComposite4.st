tests-matching-composite
testMatchComposite4
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field1').
					(ViennaUtil matchIdentifier: 'field2')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}