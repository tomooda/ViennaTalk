free variables-expressions
freeVariablesMapComprehension: aViennaNode boundVars: boundVars into: freeVars
	| binds keyExpression valueExpression bindList guardExpression |
	binds := boundVars copy.
	keyExpression := aViennaNode first.
	valueExpression := aViennaNode second.
	bindList := aViennaNode third.
	guardExpression := aViennaNode fourth.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: keyExpression boundVars: binds into: freeVars.
	self freeVariables: valueExpression boundVars: binds into: freeVars.
	self freeVariables: guardExpression boundVars: binds into: freeVars