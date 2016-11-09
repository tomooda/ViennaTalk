tests-bound variables-definitions
testBoundVariablesAssignmentDefinitionInto
	| node binds |
	node := ViennaVDMParser new assignmentDefinition end parse: 'v:t := e'.
	self deny: node isPetitFailure.
	self assert: node label = 'AssignmentDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet