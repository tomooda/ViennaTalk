free variables-statements
freeVariablesAssignmentDefinition: aViennaNode boundVars: boundVars into: freeVars
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]