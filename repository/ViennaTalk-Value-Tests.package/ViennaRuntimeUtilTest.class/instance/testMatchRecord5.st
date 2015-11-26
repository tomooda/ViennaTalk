tests-matching-record
testMatchRecord5
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}