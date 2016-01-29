bound variables-interfaces
boundVariablesValueSignature: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet