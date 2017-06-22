utilities
defineMethodFromExplicitOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode
	^ self
		defineMethodFromOperation: opName
		in: theClass
		protocol: protocolString
		fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
		body: bodyString
		pre: preString
		post: postString
		retVar: 'RESULT'
		retType: typeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode
		bodyNode: aViennaNode fifth