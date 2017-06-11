parsers-types
seqType
	^ super seqType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'SeqType'
				start: start
				end: end
				with: ast ]