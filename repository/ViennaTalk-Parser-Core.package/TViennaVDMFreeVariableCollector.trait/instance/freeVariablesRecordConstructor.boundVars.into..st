free variables-expressions
freeVariablesRecordConstructor: aViennaNode boundVars: boundVars into: freeVars
	| constructor expressionList |
	constructor := aViennaNode first.
	expressionList := aViennaNode second.
	(boundVars includes: constructor)
		ifFalse: [ freeVars add: aViennaNode first ].
	self freeVariables: expressionList boundVars: boundVars into: freeVars