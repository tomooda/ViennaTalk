parsers-patterns
seqEnumPattern
	^ (lbracket , ((pattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, rbracket) ==> #second