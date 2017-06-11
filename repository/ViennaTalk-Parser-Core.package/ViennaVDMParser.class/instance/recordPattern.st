parsers-patterns
recordPattern
	^ super recordPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'RecordPattern'
				start: start
				end: end
				withAll: array ]