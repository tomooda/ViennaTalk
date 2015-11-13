parsers-patterns
mapEnumerationPattern
	| mapletPattern |
	mapletPattern := (pattern , (self operator: '|->') , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ ((self operator: ${)
		,
			(((self operator: '|->') ==> [ :single | Array new ])
				/ (mapletPattern separatedBy: (self operator: $,)) withoutSeparators) , (self operator: $})) ==> #second