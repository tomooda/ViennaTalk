bound variables-definitions
boundVariablesExplicitFunctionDefinition: aViennaNode into: aSet
	aSet add: aViennaNode first.
	aViennaNode seventh ifNotNil: [ aSet add: 'pre_' , aViennaNode first ].
	aViennaNode eighth ifNotNil: [ aSet add: 'post_' , aViennaNode first ]