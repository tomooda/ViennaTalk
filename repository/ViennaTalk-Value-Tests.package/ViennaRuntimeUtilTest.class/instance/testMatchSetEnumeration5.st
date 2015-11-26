tests-matching-set
testMatchSetEnumeration5
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(2 1) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}