tests-matching-set
testMatchSetEnumeration7
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 3) asSet)
		equals: {}