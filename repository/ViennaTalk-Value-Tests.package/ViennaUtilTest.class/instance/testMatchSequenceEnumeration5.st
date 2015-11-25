tests-matching-sequence
testMatchSequenceEnumeration5
	self assert: ((ViennaUtil matchSequenceEnumeration: {}) value: #() asOrderedCollection) equals: {(Dictionary new)}