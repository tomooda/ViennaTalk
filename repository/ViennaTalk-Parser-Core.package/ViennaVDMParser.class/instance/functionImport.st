parsers-interfaces
functionImport
	^ super functionImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionImport'
				start: start
				end: end
				withAll: array ]