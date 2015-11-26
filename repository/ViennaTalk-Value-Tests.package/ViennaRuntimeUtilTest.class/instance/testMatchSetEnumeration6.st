tests-matching-set
testMatchSetEnumeration6
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member').
							(ViennaRuntimeUtil matchValue: 1)}).
					(ViennaRuntimeUtil matchIdentifier: 'member')})
				value:
					{2.
					(#(1 2) asSet)} asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}