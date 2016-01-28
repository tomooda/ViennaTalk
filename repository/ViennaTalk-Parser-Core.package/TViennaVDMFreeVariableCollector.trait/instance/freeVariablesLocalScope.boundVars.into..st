private
freeVariablesLocalScope: aViennaNode boundVars: boundVars into: freeVars
	| binds |
	binds := boundVars copy.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]