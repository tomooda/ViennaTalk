tests
testAtPut
	self
		assert:
			('abc' asViennaTracingString
				at: 2 put: $B;
				yourself)
		equals:
			('abc'
				at: 2 put: $B;
				yourself)