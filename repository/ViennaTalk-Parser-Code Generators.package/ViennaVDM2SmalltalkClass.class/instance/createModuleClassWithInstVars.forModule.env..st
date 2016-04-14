utilities
createModuleClassWithInstVars: anArrayOfString forModule: aString env: aDictionary
	^ self
		createModuleClassWithInstVars: anArrayOfString
		stateVars: #()
		forModule: aString
		env: aDictionary