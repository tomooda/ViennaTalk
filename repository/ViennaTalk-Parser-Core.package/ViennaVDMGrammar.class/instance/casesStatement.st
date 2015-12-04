parsers-statements
casesStatement
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesStatementAlternatives
		, ((comma , self othersStatement) ==> #second) optional , (self reserved: 'end'))
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]