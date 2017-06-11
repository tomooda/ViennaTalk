parsers-interfaces
valueSignature
	^ super valueSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueSignature'
				start: start
				end: end
				withAll: array ]