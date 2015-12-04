parsers-expressions-basics
defExpression
	^ ((self reserved: 'def') , (self equalDefinition delimitedBy: semicolon) withoutSeparators , (self reserved: 'in')
		, expression)
		==> [ :quatro | 
			| defs bodyExpr |
			defs := quatro second.
			bodyExpr := quatro fourth.
			{defs.
			bodyExpr} ]