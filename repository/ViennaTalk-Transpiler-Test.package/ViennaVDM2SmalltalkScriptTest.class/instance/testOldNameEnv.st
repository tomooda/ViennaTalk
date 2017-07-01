tests-code generation-expressions
testOldNameEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'x~'.
	self deny: node isPetitFailure.
	self assert: node label = 'OldName'.
	self assert: (Compiler evaluate: '|_oldState|_oldState := {''x'' -> 1} asDictionary. ', (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 1