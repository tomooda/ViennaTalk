parsers-definitions
operationDefinitions
	^ super operationDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			{vars.
			(array inject: '' into: [ :code :def | code , def second , '.' ])} ]