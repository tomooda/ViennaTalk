bound variables-interfaces
boundVariablesOperationImport: aViennaNode into: aSet
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet.
	aViennaNode third ifNotNil: [ :rename | aSet add: rename first ]