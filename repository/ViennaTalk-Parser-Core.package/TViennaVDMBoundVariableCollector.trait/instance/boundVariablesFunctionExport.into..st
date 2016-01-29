bound variables-interfaces
boundVariablesFunctionExport: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode third into: aSet