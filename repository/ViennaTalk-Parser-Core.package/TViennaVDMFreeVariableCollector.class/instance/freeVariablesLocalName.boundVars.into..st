free variables-expressions
freeVariablesLocalName: aViennaNode boundVars: boundVars into: freeVars
	| name |
	name := aViennaNode first.
	(boundVars includes: name)
		ifFalse: [ freeVars add: name ]