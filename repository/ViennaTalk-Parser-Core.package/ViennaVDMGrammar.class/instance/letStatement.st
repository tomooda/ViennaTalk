parsers-statements
letStatement
	^ (self let , self localDefinitionList , self in , statement)
		==> [ :quatro | 
			| localDefs bodyStatement |
			localDefs := quatro second.
			bodyStatement := quatro fourth.
			{localDefs.
			bodyStatement} ]