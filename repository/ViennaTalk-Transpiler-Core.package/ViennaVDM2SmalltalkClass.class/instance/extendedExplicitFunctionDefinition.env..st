code generation-definitions
extendedExplicitFunctionDefinition: aViennaNode env: aDictionary
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super
		extendedExplicitFunctionDefinition: aViennaNode
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode sixth
		ifNotNil: [ self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode sixth ].
	aViennaNode seventh
		ifNotNil: [ self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode seventh ]