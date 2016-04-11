free variables-definitions
freeVariablesInvariantInitialFunction: aViennaNode boundVars: boundVars into: freeVars
	| pattern expression binds |
	pattern := aViennaNode first.
	expression := aViennaNode second.
	binds := boundVars copy.
	self boundVariables: pattern into: binds.
	self freeVariables: expression boundVars: binds into: freeVars