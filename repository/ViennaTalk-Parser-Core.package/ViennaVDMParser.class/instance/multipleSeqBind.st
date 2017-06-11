parsers-patterns
multipleSeqBind
	^ super multipleSeqBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleSeqBind'
				start: start
				end: end
				withAll: array ]