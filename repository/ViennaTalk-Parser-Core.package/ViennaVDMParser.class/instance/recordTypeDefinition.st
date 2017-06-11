parsers-definitions
recordTypeDefinition
	^ super recordTypeDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'RecordTypeDefinition'
				start: start
				end: end
				withAll: array ]