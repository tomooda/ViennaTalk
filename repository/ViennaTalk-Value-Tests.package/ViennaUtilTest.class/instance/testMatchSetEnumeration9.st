tests-matching-set
testMatchSetEnumeration9
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}) value: #(1 2) asSet)
		equals: {}