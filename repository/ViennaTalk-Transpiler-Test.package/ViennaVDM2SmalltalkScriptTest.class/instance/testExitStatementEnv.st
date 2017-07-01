tests-code generation-statements
testExitStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'exit 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExitStatement'.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node) ]
		raise: ViennaException
		withExceptionDo: [ :ex | self assert: ex expression equals: 1 ]