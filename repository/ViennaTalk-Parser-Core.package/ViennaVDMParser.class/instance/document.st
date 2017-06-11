parsers-definitions
document
	^ super document
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Document'
				start: start
				end: end
				withAll: array ]