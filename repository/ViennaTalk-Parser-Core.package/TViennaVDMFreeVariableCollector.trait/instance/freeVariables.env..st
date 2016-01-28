free variables
freeVariables: aViennaNode env: aDictionary
	| freeVars |
	freeVars := Set new: 16.
	self freeVariables: aViennaNode env: aDictionary keys asSet into: freeVars.
	^ freeVars asArray