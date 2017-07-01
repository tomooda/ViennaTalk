free variables-expressions
freeVariablesDefExpression: aViennaNode boundVars: boundVars into: freeVars
	| binds equalDefinitionList bodyExpression |
	binds := boundVars copy.
	equalDefinitionList := aViennaNode first.
	bodyExpression := aViennaNode second.
	self boundVariables: equalDefinitionList into: binds.
	self freeVariables: equalDefinitionList boundVars: binds into: freeVars.
	self freeVariables: bodyExpression boundVars: binds into: freeVars