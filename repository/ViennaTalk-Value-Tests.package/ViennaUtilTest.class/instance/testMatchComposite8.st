tests-matching-composite
testMatchComposite8
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 2)}) value: (ViennaComposite type: 't2' with: 1 with: 2))
		equals: {}