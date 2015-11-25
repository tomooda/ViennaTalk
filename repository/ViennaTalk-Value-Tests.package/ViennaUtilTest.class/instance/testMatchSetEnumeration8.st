tests-matching-set
testMatchSetEnumeration8
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2 3) asSet)
		equals: {}