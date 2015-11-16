parsers-expressions-basics
mapEnumeration
	^ (lbrace
		,
			((maplet ==> [ :single | Array new ])
				/
					((expression , maplet , expression)
						==> [ :triple | 
							{(triple first).
							(triple third)} ] separatedBy: comma) withoutSeparators) , rbrace) ==> #second