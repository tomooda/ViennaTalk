bound variables-patterns and binds
boundVariablesPatternIdentifier: aViennaNode into: aSet
	aViennaNode first ifNotNil: [ :string | aSet add: string ]