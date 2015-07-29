tests
testMap3
	self
		assert: (reader parse: '{1 |-> 2}')
		equals:
			(Dictionary new
				at: 1 put: 2;
				yourself)