free variables-expressions
freeVariablesGlobalName: aViennaNode boundVars: boundVars into: freeVars
	| name |
	name := aViennaNode first , '`' , aViennaNode second.
	(boundVars includes: name)
		ifFalse: [ freeVars add: name ]