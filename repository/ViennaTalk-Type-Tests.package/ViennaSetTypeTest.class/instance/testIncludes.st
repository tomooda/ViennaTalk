tests
testIncludes
	self assert: (setofnat includes: {} asSet).
	self assert: (setofnat includes: {1} asSet).
	self deny: (setofnat includes: {1 . -1} asSet)