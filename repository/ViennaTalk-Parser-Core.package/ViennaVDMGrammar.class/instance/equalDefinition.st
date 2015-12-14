parsers-definitions
equalDefinition
	^ (patternBind , eq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]