parsers-patterns
fieldPattern
	^ (identifier trim , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]