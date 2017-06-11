parsers-interfaces
importFunctionsSignature
	^ super importFunctionsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportFunctionsSignature'
				start: start
				end: end
				withAll: array ]