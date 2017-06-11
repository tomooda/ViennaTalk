parsers-patterns
seqConcPattern
	^ super seqConcPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqConcPattern'
				start: start
				end: end
				withAll: array ]