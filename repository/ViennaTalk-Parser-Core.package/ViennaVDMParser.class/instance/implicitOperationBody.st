parsers-definitions
implicitOperationBody
	^ super implicitOperationBody
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitOperationBody'
				start: start
				end: end
				withAll: array ]