variables
freeVariablesLambda: aViennaNode boundVars: boundVars into: freeVars
	| binds |
	binds := Set new: 16.
	aViennaNode first
		do: [ :bind | 
			self freeVariables: bind first boundVars: boundVars into: binds.
			self freeVariables: bind second boundVars: boundVars into: freeVars ].
	binds addAll: boundVars.
	self freeVariables: aViennaNode second boundVars: binds into: freeVars