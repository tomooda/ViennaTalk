parsers-definitions
accessFunctionDefinition
	^ (access optional , self functionDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]