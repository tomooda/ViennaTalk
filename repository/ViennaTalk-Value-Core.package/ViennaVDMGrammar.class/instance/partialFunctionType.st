parsers-types
partialFunctionType
	^ (type1 , (self operator: '->') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]