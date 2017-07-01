free variables-statements
freeVariablesLetStatement: aViennaNode boundVars: boundVars into: freeVars
	| binds localDefinitionList bodyStatement |
	binds := boundVars copy.
	localDefinitionList := aViennaNode first.
	bodyStatement := aViennaNode second.
	self boundVariables: localDefinitionList into: binds.
	self freeVariables: localDefinitionList boundVars: binds into: freeVars.
	self freeVariables: bodyStatement boundVars: binds into: freeVars