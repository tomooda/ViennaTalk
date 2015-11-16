parsers-definitions
valueDefinition
	^ super valueDefinition
		==> [ :triple | 
			{(triple first).
			(triple third)} ]