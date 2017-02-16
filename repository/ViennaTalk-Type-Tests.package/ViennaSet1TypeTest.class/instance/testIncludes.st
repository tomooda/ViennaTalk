tests
testIncludes
	self deny: (set1ofnat includes: {} asSet).
	self assert: (set1ofnat includes: {1} asSet).
	self deny: (set1ofnat includes: {1 . -1} asSet)