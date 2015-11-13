parsers-patterns
recordPattern
	^ (('mk_' asParser , identifier , (self operator: $()) ==> #second
		,
			((pattern separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :triple | 
			{(triple first).
			(triple second)} ]