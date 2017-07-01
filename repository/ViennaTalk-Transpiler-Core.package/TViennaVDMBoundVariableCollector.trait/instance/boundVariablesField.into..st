bound variables-types
boundVariablesField: aViennaNode into: aSet
	aViennaNode first ifNotNil: [ :name | aSet add: name ]