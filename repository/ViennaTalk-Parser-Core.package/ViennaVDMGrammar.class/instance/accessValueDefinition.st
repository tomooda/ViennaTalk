parsers-definitions
accessValueDefinition
	^ (access optional , valueDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]