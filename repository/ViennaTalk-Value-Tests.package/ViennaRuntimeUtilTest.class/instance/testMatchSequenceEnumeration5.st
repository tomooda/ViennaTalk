tests-matching-sequence
testMatchSequenceEnumeration5
	self assert: ((ViennaRuntimeUtil matchSequenceEnumeration: {}) value: #() asOrderedCollection) equals: {(Dictionary new)}