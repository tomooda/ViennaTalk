parsers-patterns
objectPattern
	| fieldPattern |
	fieldPattern := (identifier , maplet , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ ('obj_' asParser , identifier , lparen
		, ((fieldPattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]