parsers-patterns
seqBind
	^ super seqBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqBind'
				start: start
				end: end
				withAll: array ]