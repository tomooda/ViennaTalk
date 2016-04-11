free variables-statements
freeVariablesLetBeStatement: aViennaNode boundVars: boundVars into: freeVars
	| binds multipleBind guardExpression bodyStatement |
	binds := boundVars copy.
	multipleBind := aViennaNode first.
	guardExpression := aViennaNode second.
	bodyStatement := aViennaNode third.
	self freeVariables: multipleBind boundVars: binds into: freeVars.
	self boundVariables: multipleBind into: binds.
	self freeVariables: guardExpression boundVars: binds into: freeVars.
	self freeVariables: bodyStatement boundVars: binds into: freeVars