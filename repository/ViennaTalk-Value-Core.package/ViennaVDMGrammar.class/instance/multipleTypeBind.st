parsers-patterns
multipleTypeBind
	^ (patternList , (self operator: $:) , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]