parsers-definitions
valueDefinitions
	^ super valueDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :valdef | vs , valdef first ].
			{vars.
			(array inject: '' into: [ :code :valdef | code , valdef second , '.' ])} ]