parsers-types
setType
	^ super setType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'SetType'
				start: start
				end: end
				with: ast ]