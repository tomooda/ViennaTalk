free variables-expressions
freeVariablesLambda: aViennaNode boundVars: boundVars into: freeVars
	| binds typeBindList expressionBody |
	binds := boundVars copy.
	typeBindList := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: typeBindList boundVars: binds into: freeVars.
	self boundVariables: typeBindList into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars