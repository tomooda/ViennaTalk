tests-code generation-expressions
testIsSubclassResponsibilityEnv
	| node |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'f:t1->t2 f(x) == is subclass responsibility'.
	self deny: node isPetitFailure.
	node := node at: 6.
	self assert: node label = 'IsSubclassResponsibility'.
	self
		should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ]
		raise: SubclassResponsibility