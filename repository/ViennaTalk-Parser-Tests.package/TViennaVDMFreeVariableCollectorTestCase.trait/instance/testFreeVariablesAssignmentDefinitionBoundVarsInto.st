tests-free variables-statements
testFreeVariablesAssignmentDefinitionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new assignmentDefinition end parse: 'v1:t1 := e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'AssignmentDefinition'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'e1'} asSet