variables
freeVariablesLocalName: aViennaNode boundVars: aSet into: free
	| name |
	name := aViennaNode first.
	(aSet includes: name)
		ifFalse: [ free add: name ]