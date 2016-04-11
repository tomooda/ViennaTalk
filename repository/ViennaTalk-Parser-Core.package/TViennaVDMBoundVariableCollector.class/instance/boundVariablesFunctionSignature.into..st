bound variables-interfaces
boundVariablesFunctionSignature: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ]