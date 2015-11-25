tests-matching-set
testMatchSetEnumeration1
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}