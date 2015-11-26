tests-matching-record
testMatchRecord8
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 2)}) value: (ViennaComposite type: 't2' with: 1 with: 2))
		equals: {}