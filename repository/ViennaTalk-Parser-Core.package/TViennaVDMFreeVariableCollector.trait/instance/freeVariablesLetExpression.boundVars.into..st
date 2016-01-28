free variables-expressions
freeVariablesLetExpression: aViennaNode boundVars: boundVars into: freeVars
	| binds localDefinitionList bodyExpression |
	binds := boundVars copy.
	localDefinitionList := aViennaNode first.
	bodyExpression := aViennaNode second.
	self freeVariables: localDefinitionList boundVars: binds into: freeVars.
	self boundVariables: bodyExpression into: binds.
	self freeVariables: bodyExpression boundVars: binds into: freeVars