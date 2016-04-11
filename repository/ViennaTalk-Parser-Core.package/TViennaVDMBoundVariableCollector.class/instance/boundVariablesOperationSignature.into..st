bound variables-interfaces
boundVariablesOperationSignature: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet