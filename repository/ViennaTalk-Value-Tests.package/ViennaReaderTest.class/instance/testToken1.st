tests
testToken1
	self assert: (reader parse: 'mk_token(1)') equals: (VDMComposite type: #token with: 1)