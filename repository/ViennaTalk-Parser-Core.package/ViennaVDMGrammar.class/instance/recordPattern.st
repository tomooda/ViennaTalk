parsers-patterns
recordPattern
	^ (('mk_' asParser , identifier , lparen) ==> #second
		, (patternList optional ==> [ :single | single ifNil: [ Array new ] ]) , rparen)
		==> [ :triple | 
			{(triple first).
			(triple second)} ]