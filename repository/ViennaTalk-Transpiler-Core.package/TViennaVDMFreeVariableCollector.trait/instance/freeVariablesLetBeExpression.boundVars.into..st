free variables-expressions
freeVariablesLetBeExpression: aViennaNode boundVars: boundVars into: freeVars
	| binds multipleBind guardExpression bodyExpression |
	binds := boundVars copy.
	multipleBind := aViennaNode first.
	guardExpression := aViennaNode second.
	bodyExpression := aViennaNode third.
	self freeVariables: multipleBind boundVars: binds into: freeVars.
	self boundVariables: multipleBind into: binds.
	self freeVariables: guardExpression boundVars: binds into: freeVars.
	self freeVariables: bodyExpression boundVars: binds into: freeVars