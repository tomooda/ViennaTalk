utilities
translateExplicitFunction: aString
	^ self new generate: (ViennaVDMParser new explicitFunctionDefinition end parse: aString)