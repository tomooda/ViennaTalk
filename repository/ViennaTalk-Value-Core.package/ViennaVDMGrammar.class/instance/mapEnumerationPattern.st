parsers-patterns
mapEnumerationPattern
	| mapletPattern |
	mapletPattern := (pattern , maplet , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ (lbrace , ((maplet ==> [ :single | Array new ]) / (mapletPattern separatedBy: comma) withoutSeparators) , rbrace)
		==> #second