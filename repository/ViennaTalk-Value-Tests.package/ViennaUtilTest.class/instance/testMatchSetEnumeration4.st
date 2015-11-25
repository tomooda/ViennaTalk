tests-matching-set
testMatchSetEnumeration4
	self assert: ((ViennaUtil matchSetEnumeration: {}) value: #() asSet) equals: {(Dictionary new)}