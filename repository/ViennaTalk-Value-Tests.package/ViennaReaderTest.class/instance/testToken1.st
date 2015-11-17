tests
testToken1
	self assert: (reader parse: 'mk_token(1)') equals: (ViennaComposite type: #token with: 1)