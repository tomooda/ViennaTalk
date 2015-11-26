tests-matching-record
testMatchRecord2
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}