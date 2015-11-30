tests-matching-record
testMatchRecord1
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}