tests-matching-composite
testMatchComposite6
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 3)}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {}