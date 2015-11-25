tests-matching-set
testMatchSetEnumeration2
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}