parsers-definitions
accessValueDefinition
	^ (access optional , self valueDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]