parsers-interfaces
exportFunctionsSignature
	^ super exportFunctionsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExportFunctionsSignature'
				start: start
				end: end
				withAll: array ]