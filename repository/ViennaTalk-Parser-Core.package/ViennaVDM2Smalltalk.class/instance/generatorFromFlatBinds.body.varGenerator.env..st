utilities
generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary
	^ self
		generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
		selector: #do:
		whenMatchFailed: nil
		body: aString
		varGenerator: varGenerator
		env: aDictionary