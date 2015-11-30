tests-matching-record
testMatchRecord6
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 3)}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals: {}