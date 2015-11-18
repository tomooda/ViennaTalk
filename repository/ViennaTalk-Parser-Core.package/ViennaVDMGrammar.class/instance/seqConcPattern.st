parsers-patterns
seqConcPattern
	^ (pattern1 , (self operator: '^') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]