parsers-definitions
flatDocument
	^ super flatDocument
		==> [ :array | 
			| vars bodies |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			bodies := array collect: #second.
			'|' , (' ' join: vars) , '|' , ('' join: bodies) ]