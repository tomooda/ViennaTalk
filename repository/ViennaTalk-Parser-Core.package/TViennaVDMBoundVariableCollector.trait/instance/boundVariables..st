bound variables
boundVariables: aViennaNode
	| boundVars |
	boundVars := Set new.
	self boundVariables: aViennaNode into: boundVars.
	^ boundVars