code generation-definitions
valueDefinitions: aViennaNode env: aDictionary in: aClass
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary) , '. ' , identifier
						in: aClass
						protocol: 'values'.
					aDictionary at: identifier put: 'self ' , identifier ] ]