parsers-definitions
document
	^ super document
		==> [ :array | 
			| vars bodies |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			bodies := array collect: #second.
			'|' , (' ' join: vars) , '|' , ('' join: bodies) ]