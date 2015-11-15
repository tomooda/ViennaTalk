parsers-expressions
mapEnumeration
	^ ((self operator: ${)
		,
			(((self operator: '|->') ==> [ :single | Array new ])
				/
					((expression , (self operator: '|->') , expression)
						==> [ :triple | 
							{(triple first).
							(triple third)} ] separatedBy: (self operator: $,)) withoutSeparators) , (self operator: $})) ==> #second