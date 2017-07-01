code generation-definitions
valueDefinitions: aViennaNode env: aDictionary
	| theClass initializer |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	aViennaNode
		do: [ :node | 
			initializer := self generate: node env: aDictionary.
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: initializer , '. ' , identifier
						in: theClass
						protocol: 'values'
						node: node ] ]