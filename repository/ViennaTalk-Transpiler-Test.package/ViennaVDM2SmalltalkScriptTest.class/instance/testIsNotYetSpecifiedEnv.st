tests-code generation-expressions
testIsNotYetSpecifiedEnv
	| node |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'f:t1->t2 f(x) == is not yet specified'.
	self deny: node isPetitFailure.
	node := node at: 6.
	self assert: node label = 'IsNotYetSpecified'.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) ]
		raise: NotYetImplemented