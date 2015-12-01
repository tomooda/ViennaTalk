tests
testName
	self assert: (int inv: [ :i | i < 0 ]) name equals: 'int inv [ :i | i < 0 ]'