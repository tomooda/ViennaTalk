free variables-expressions
freeVariablesCasesExpressionAlternative: aViennaNode boundVars: boundVars into: freeVars
	| binds patterns expressionBody |
	binds := boundVars copy.
	patterns := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: patterns boundVars: binds into: freeVars.
	self boundVariables: patterns into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars