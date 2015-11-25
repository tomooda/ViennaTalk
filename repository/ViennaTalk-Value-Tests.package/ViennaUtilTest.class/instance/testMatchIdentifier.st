tests-matching-basic
testMatchIdentifier
	self
		assert: ((ViennaUtil matchIdentifier: 'var') value: 1)
		equals:
			{(Dictionary new
				at: 'var' put: 1;
				yourself)}