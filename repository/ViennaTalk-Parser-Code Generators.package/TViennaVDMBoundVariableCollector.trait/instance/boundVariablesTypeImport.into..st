bound variables-interfaces
boundVariablesTypeImport: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode second ifNotNil: [ :rename | aSet add: rename first ]