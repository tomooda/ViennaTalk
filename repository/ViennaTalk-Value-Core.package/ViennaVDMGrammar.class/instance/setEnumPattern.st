parsers-patterns
setEnumPattern
	^ ((self operator: ${)
		,
			((pattern separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, (self operator: $})) ==> #second