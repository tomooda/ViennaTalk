tests-matching-set
testMatchSetEnumeration7
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 3) asSet)
		equals: {}