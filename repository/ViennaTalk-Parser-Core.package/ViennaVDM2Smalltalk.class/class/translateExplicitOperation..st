utilities
translateExplicitOperation: aString
	^ self new generate: (ViennaVDMParser new explicitOperationDefinition end parse: aString)