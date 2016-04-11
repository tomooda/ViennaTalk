code generation-definitions
explicitFunctionDefinition: aViennaNode env: aDictionary
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super explicitFunctionDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'