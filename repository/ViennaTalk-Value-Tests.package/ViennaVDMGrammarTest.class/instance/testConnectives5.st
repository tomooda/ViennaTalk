tests-expressions
testConnectives5
	self
		assert: (grammar expression end parse: 'not e1 <=> e2 => e3 or e4 and e5')
		equals: #('e1' #('e2' #('e3' #('e4' 'e5'))))