parsers-definitions
typeDefinitions
	^ super typeDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :typedef | vs , typedef first ].
			{vars.
			(array inject: '' into: [ :code :typedef | code , typedef second ])} ]