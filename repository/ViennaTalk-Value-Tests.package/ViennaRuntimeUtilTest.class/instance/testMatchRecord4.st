tests-matching-record
testMatchRecord4
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field1').
					(ViennaRuntimeUtil matchIdentifier: 'field2')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}