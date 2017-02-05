bound variables-definitions
boundVariablesExtendedExplicitFunctionDefinition: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode sixth ifNotNil: [ aSet add: 'pre_' , aViennaNode first ].
	aSet add: 'post_' , aViennaNode first