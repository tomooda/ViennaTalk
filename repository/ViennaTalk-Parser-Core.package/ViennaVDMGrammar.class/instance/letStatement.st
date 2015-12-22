parsers-statements
letStatement
	^ ((self reserved: 'let') , self localDefinitionList , (self reserved: 'in') , statement)
		==> [ :quatro | 
			| localDefs bodyStatement |
			localDefs := quatro second.
			bodyStatement := quatro fourth.
			{localDefs.
			bodyStatement} ]