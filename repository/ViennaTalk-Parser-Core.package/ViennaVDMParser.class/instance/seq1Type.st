parsers-types
seq1Type
	^ super seq1Type
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'Seq1Type'
				start: start
				end: end
				with: ast ]