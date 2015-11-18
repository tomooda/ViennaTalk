parsers-patterns
setEnumPattern
	^ (lbrace , ((pattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, rbrace) ==> #second