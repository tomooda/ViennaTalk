code generation-definitions
valueDefinition: aViennaNode env: aDictionary
	| theClass initializer |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	initializer := super valueDefinition: aViennaNode env: aDictionary.
	(self boundVariables: aViennaNode)
		do: [ :identifier | 
			self
				defineLazyMethodNamed: identifier
				initializer: initializer , '. ' , identifier
				in: theClass
				protocol: 'values' ]