free variables-definitions
freeVariablesStateDefinition: aViennaNode boundVars: boundVars into: aSet
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: aSet ]