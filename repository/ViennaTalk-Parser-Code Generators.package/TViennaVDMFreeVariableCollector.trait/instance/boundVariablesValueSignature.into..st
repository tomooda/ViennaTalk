bound variables-interfaces
boundVariablesValueSignature: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode second boundVars: aSet into: aSet