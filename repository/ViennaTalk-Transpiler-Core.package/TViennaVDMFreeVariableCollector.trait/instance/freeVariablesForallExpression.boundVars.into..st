free variables-expressions
freeVariablesForallExpression: aViennaNode boundVars: boundVars into: freeVars
	| binds bindList expressionBody |
	binds := boundVars copy.
	bindList := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars