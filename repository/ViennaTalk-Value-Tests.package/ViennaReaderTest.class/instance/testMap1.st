tests
testMap1
	self
		assert: (reader parse: '{1|->2, 3|->4}')
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 3 put: 4;
				yourself)