parsers-statements
defStatement
	^ ((self reserved: 'def') , (self equalDefinition delimitedBy: semicolon) withoutSeparators , (self reserved: 'in')
		, statement)
		==> [ :quatro | 
			| defs bodyStatement |
			defs := quatro second.
			bodyStatement := quatro fourth.
			{defs.
			bodyStatement} ]