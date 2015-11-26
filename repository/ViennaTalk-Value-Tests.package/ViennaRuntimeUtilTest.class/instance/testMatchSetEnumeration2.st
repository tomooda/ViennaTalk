tests-matching-set
testMatchSetEnumeration2
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}