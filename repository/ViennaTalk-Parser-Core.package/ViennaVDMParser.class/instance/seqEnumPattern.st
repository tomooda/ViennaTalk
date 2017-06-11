parsers-patterns
seqEnumPattern
	^ super seqEnumPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqEnumPattern'
				start: start
				end: end
				withAll: array ]