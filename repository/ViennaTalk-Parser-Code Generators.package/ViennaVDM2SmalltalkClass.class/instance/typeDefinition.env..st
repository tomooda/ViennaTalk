code generation-definitions
typeDefinition: aViennaNode env: aDictionary
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super typeDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'