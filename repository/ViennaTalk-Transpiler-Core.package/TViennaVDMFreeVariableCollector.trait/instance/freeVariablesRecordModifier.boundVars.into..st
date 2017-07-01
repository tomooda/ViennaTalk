free variables-expressions
freeVariablesRecordModifier: aViennaNode boundVars: boundVars into: freeVars
	| record mapletList |
	record := aViennaNode first.
	mapletList := aViennaNode second.
	self freeVariables: record boundVars: boundVars into: freeVars.
	mapletList
		do: [ :maplet | 
			| valueExpression |
			valueExpression := maplet second.
			self freeVariables: valueExpression boundVars: boundVars into: freeVars ]