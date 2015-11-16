parsers-patterns
recordPattern
	^ (('mk_' asParser , identifier , lparen) ==> #second
		, ((pattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]) , rparen)
		==> [ :triple | 
			{(triple first).
			(triple second)} ]