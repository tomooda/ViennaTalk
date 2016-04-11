free variables-statements
freeVariablesCasesStatementAlternative: aViennaNode boundVars: boundVars into: freeVars
	| binds patterns bodyStatement |
	binds := boundVars copy.
	patterns := aViennaNode first.
	bodyStatement := aViennaNode second.
	self freeVariables: patterns boundVars: binds into: freeVars.
	self boundVariables: patterns into: binds.
	self freeVariables: bodyStatement boundVars: binds into: freeVars