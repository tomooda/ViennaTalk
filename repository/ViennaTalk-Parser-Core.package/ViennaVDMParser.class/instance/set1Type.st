parsers-types
set1Type
	^ super set1Type
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'Set1Type'
				start: start
				end: end
				with: ast ]