parsers-types
optionalType
	^ super optionalType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'OptionalType'
				start: start
				end: end
				with: ast ]