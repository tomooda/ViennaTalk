parsers-patterns
objectPattern
	| fieldPattern |
	fieldPattern := (identifier , (self operator: '|->') , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ ('obj_' asParser , identifier , (self operator: $()
		,
			((fieldPattern separatedBy: (self operator: $,)) withoutSeparators optional
				==> [ :single | single ifNil: [ Array new ] ]) , (self operator: $)))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]