tests
testIncludes
	self deny: (seq1ofnat includes: #() asOrderedCollection).
	self assert: (seq1ofnat includes: #(1) asOrderedCollection).
	self deny: (seq1ofnat includes: #(1 2.3) asOrderedCollection)