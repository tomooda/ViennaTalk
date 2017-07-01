free variables-definitions
freeVariablesField: aViennaNode boundVars: boundVars into: freeVars
	| type |
	type := aViennaNode third.
	self freeVariables: type boundVars: boundVars into: freeVars