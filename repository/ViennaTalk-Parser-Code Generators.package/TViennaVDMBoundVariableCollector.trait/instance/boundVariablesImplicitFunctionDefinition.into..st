bound variables-definitions
boundVariablesImplicitFunctionDefinition: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode fifth ifNotNil: [ aSet add: 'pre_' , aViennaNode first ].
	aSet add: 'post_' , aViennaNode first