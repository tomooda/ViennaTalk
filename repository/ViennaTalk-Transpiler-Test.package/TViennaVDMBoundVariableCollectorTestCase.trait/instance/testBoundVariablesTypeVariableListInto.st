tests-bound variables-definitions
testBoundVariablesTypeVariableListInto
	| node binds |
	node := ViennaVDMParser new typeVariableList end parse: '[@t1, @t2]'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariableList'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'@t1'.
			'@t2'} asSet