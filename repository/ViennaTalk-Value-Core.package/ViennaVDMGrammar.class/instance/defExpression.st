parsers-expressions-basics
defExpression
	^ ((self reserved: 'def')
		,
			((patternBind , eq , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] delimitedBy: semicolon) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]