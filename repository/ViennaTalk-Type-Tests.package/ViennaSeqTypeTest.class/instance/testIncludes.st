tests
testIncludes
	self assert: (seqofnat includes: #() asOrderedCollection).
	self assert: (seqofnat includes: #(1) asOrderedCollection).
	self deny: (seqofnat includes: #(1 2.3) asOrderedCollection)