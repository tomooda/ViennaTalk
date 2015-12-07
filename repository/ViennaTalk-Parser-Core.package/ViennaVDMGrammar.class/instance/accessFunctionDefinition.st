parsers-definitions
accessFunctionDefinition
	^ (access optional , functionDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]