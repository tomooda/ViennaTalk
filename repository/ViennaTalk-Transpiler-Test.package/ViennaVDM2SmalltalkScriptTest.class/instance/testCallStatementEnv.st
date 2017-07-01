tests-code generation-statements
testCallStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'op(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'CallStatement'.
	self
		assert: (Compiler evaluate: '|op x| x:= 0. op := [:a | x := a]. ' , (ViennaVDM2SmalltalkScript new generate: node) , '.x')
		equals: 1