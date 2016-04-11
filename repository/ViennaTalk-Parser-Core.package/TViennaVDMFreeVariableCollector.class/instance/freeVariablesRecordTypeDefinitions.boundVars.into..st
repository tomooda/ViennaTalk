free variables-definitions
freeVariablesRecordTypeDefinitions: aViennaNode boundVars: boundVars into: freeVars
	| binds identifier fieldList inv |
	binds := boundVars copy.
	identifier := aViennaNode first.
	fieldList := aViennaNode second.
	inv := aViennaNode third.
	binds add: identifier.
	self freeVariables: fieldList boundVars: binds into: freeVars.
	self freeVariables: inv boundVars: binds into: freeVars