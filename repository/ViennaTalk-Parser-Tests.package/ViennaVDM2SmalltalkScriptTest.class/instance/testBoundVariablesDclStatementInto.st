tests-bound variables-statements
testBoundVariablesDclStatementInto
	| node binds |
	node := ViennaVDMParser new dclStatement end parse: 'dcl v1:t1 := e, v2:t := v1;'.
	self deny: node isPetitFailure.
	self assert: node label = 'DclStatement'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet