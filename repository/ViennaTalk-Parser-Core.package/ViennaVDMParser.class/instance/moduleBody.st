parsers-definitions
moduleBody
	^ super moduleBody
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ModuleBody'
				start: start
				end: end
				withAll: array ]