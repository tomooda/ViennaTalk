parsers-expressions-basics
recordModifier
	^ ((self reserved: 'mu') , lparen , expression , comma
		,
			((identifier , maplet , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]