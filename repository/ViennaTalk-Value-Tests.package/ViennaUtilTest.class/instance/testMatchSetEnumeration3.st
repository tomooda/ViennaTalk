tests-matching-set
testMatchSetEnumeration3
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2) asSet)
		equals: {(Dictionary new)}