parsers-types
operationType
	^ (discretionaryType , (self operator: '==>') , discretionaryType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]