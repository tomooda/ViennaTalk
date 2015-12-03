parsers-expressions-basics
recordModifier
	^ ((self reserved: 'mu') , lparen , expression , comma
		,
			((identifier , mapletArrow , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]