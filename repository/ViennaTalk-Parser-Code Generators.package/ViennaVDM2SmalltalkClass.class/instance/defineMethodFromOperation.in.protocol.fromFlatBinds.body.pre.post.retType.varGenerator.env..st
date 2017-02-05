utilities
defineMethodFromOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retType: typeNode varGenerator: varGenerator env: aDictionary
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