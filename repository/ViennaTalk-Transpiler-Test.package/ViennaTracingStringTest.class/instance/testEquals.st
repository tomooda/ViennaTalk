tests
testEquals
	self assert: 'abc' asViennaTracingString = 'abc'.
	self assert: 'abc' asViennaTracingString = ('abc' asViennaTracingString: 1).
	self assert: 'abc' = 'abc' asViennaTracingString