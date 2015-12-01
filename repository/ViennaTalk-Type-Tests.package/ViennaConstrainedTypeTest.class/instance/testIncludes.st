tests
testIncludes
	self assert: ((int inv: [ :i | i < 0 ]) includes: -1).
	self deny: ((int inv: [ :i | i < 0 ]) includes: 1)