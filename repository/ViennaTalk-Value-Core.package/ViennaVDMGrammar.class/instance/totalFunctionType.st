parsers-types
totalFunctionType
	^ (type1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]