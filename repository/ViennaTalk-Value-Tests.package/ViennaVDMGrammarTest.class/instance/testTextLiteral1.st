tests-literals
testTextLiteral1
	self assert: (grammar expression end parse: '"A\101\x41\u0041\""') equals: 'AAAA"'