bound variables-interfaces
boundVariablesFunctionExport: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode third boundVars: aSet into: aSet