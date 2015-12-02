parsers-types
partialFunctionType
	^ (self discretionaryType1 , (self operator: '->') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]