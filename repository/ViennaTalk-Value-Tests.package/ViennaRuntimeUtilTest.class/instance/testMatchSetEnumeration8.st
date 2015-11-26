tests-matching-set
testMatchSetEnumeration8
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2 3) asSet)
		equals: {}