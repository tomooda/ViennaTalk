free variables-statements
freeVariablesSetForLoop: aViennaNode boundVars: boundVars into: freeVars
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]