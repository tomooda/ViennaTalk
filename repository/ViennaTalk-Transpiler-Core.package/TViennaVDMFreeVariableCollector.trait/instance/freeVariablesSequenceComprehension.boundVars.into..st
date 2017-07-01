free variables-expressions
freeVariablesSequenceComprehension: aViennaNode boundVars: boundVars into: freeVars
	| binds expression bindList guardExpression |
	binds := boundVars copy.
	expression := aViennaNode first.
	bindList := aViennaNode second.
	guardExpression := aViennaNode third.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expression boundVars: binds into: freeVars.
	self freeVariables: guardExpression boundVars: binds into: freeVars