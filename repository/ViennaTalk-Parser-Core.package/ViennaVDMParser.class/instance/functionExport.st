parsers-interfaces
functionExport
	^ super functionExport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionExport'
				start: start
				end: end
				withAll: array ]