tests-matching-composite
testMatchComposite7
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {}