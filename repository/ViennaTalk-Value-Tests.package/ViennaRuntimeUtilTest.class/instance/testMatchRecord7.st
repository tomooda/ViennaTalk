tests-matching-record
testMatchRecord7
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals: {}