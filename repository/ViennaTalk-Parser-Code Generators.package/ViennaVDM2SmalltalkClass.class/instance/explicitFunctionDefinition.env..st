code generation-definitions
explicitFunctionDefinition: aViennaNode env: aDictionary
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super
		explicitFunctionDefinition: aViennaNode
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode seventh
		ifNotNil: [ self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode seventh ].
	aViennaNode eighth
		ifNotNil: [ self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode eighth ]