parsers-types
totalFunctionType
	^ (self discretionaryType1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]