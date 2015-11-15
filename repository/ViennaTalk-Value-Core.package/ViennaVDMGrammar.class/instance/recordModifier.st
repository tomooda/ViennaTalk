parsers-expressions
recordModifier
	^ ((self reserved: 'mu') , (self operator: $() , expression , (self operator: $,)
		,
			((identifier , (self operator: '|->') , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: (self operator: $,)) withoutSeparators , (self operator: $)))
		==> [ :array | 
			{(array third).
			(array fifth)} ]