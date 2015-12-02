parsers-types
seqType
	^ super seqType ==> [ :ast | ViennaNode label: 'SeqType' with: ast ]