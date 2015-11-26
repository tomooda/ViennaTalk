tests-matching-set
testMatchSetEnumeration9
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2) asSet)
		equals: {}