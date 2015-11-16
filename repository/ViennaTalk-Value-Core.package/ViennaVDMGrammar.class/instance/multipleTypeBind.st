parsers-patterns
multipleTypeBind
	^ (patternList , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]