free variables-expressions
freeVariablesIotaExpression: aViennaNode boundVars: boundVars into: freeVars
	| binds typeBind expressionBody |
	binds := boundVars copy.
	typeBind := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: typeBind boundVars: binds into: freeVars.
	self boundVariables: typeBind into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars