parsers-interfaces
typeImport
	^ super typeImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeImport'
				start: start
				end: end
				withAll: array ]