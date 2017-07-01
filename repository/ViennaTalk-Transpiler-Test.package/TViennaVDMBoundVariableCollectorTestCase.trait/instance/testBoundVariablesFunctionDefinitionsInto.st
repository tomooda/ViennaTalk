tests-bound variables-definitions
testBoundVariablesFunctionDefinitionsInto
	| node binds |
	node := ViennaVDMParser new functionDefinitions end
		parse: 'functions fn1[@t] : t1 -> t2 fn1(x) == e1; fn2[@t] : t3 -> t4 fn2(y) == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'fn1'.
			'fn2'} asSet