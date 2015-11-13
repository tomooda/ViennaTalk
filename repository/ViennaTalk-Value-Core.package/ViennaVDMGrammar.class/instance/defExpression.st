parsers-expressions
defExpression
	^ ((self reserved: 'def')
		,
			((patternBind , (self operator: $=) , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] delimitedBy: (self operator: $;)) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]