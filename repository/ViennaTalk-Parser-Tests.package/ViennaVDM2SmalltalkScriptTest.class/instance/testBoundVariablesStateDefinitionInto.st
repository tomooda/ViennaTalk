tests-bound variables-definitions
testBoundVariablesStateDefinitionInto
	| node binds |
	node := ViennaVDMParser new stateDefinition end
		parse: 'state S of v1 : t1 v2 : t2 inv mk_S(inv1, inv2) == inv1 = inv2 init s == s = mk_S(e1, e2) end'.
	self deny: node isPetitFailure.
	self assert: node label = 'StateDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'S'.
			'v1'.
			'v2'.
			'inv_S'.
			'init_S'} asSet