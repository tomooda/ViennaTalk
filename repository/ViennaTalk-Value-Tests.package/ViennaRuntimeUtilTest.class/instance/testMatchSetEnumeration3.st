tests-matching-set
testMatchSetEnumeration3
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asSet)
		equals: {(Dictionary new)}