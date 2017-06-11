parsers-types
basicType
	^ super basicType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'BasicType'
				start: start
				end: end
				with: ast ]