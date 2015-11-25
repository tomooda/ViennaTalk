tests-matching-set
testMatchSetEnumeration5
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(2 1) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}