tests-matching-record
testMatchRecord3
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {(Dictionary new)}