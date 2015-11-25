tests-matching-set
testMatchSetEnumeration6
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member').
							(ViennaUtil matchValue: 1)}).
					(ViennaUtil matchIdentifier: 'member')})
				value:
					{2.
					(#(1 2) asSet)} asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}