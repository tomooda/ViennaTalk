tests-matching-basic
testMatchValue1
	self assert: ((ViennaRuntimeUtil matchValue: 1) value: 1) equals: {(Dictionary new)}