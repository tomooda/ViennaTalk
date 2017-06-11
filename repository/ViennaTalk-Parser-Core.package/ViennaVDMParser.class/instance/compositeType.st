parsers-types
compositeType
	^ super compositeType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'CompositeType'
				start: start
				end: end
				withAll: array ]