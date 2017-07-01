bound variables-definitions
boundVariablesImplicitOperationDefinition: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode fourth second ifNotNil: [ aSet add: 'pre_' , aViennaNode first ].
	aSet add: 'post_' , aViennaNode first