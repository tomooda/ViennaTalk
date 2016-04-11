bound variables-interfaces
boundVariablesFunctionImport: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode third into: aSet.
	aViennaNode fourth ifNotNil: [ :rename | aSet add: rename first ]