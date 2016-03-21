code generation-definitions
operationDefinitions: aViennaNode env: aDictionary in: aClass
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary)
						in: aClass
						protocol: 'operations' ] ]