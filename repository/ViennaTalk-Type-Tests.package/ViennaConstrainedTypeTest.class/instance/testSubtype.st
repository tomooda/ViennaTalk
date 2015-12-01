tests
testSubtype
	self assert: (int inv: [ :i | i < 0 ]) <= int.
	self deny: int <= (int inv: [ :i | i < 0 ]).
	self deny: (int inv: [ :i | i > 1 ]) <= (int inv: [ :i | i > 0 ])