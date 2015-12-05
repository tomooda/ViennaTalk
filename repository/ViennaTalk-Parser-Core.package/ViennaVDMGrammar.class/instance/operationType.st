parsers-types
operationType
	^ (self discretionaryType , (self operator: '==>') , self discretionaryType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]