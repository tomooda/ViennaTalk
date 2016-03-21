utilities
closureFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary
	^ self
		closureFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
		body: aString
		varGenerator: varGenerator
		env: aDictionary
		op: false