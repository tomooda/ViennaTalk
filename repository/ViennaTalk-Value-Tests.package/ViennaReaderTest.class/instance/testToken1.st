tests
testToken1
	self assert: (reader parse: 'mk_token(1)') equals: (ViennaComposite constructorName: #token with: 1)