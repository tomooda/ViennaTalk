code generation-definitions
implicitFunctionDefinition: aViennaNode env: aDictionary
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super implicitFunctionDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'.
	aViennaNode fifth
		ifNotNil: [ 
			self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions' ].
	aViennaNode sixth
		ifNotNil: [ 
			self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions' ]