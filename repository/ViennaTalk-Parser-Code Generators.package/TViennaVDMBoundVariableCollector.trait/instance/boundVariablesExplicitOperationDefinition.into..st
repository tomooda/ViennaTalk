bound variables-definitions
boundVariablesExplicitOperationDefinition: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode sixth ifNotNil: [ aSet add: 'pre_' , aViennaNode first ].
	aViennaNode seventh ifNotNil: [ aSet add: 'post_' , aViennaNode first ]