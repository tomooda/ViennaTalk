parsers-statements
letStatement
	^ ((self reserved: 'let') , (self localDefinition separatedBy: comma) withoutSeparators , (self reserved: 'in')
		, statement)
		==> [ :quatro | 
			| localDefs bodyStatement |
			localDefs := quatro second.
			bodyStatement := quatro fourth.
			{localDefs.
			bodyStatement} ]