tests-matching-composite
testMatchComposite3
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {(Dictionary new)}