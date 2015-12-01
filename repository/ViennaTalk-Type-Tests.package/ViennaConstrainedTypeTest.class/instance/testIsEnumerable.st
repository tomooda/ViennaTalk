tests
testIsEnumerable
	self deny: (int inv: [ :i | i < 0 ]) isEnumerable.
	self assert: (bool inv: [ :b | b ]) isEnumerable