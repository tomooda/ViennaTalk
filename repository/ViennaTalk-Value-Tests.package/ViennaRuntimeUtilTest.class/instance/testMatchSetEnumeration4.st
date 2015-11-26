tests-matching-set
testMatchSetEnumeration4
	self assert: ((ViennaRuntimeUtil matchSetEnumeration: {}) value: #() asSet) equals: {(Dictionary new)}