parsers-expressions-basics
equalDefinition
	^ (patternBind , eq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]