parsers-statements
casesStatement
	^ ((self cases , expression , colon) ==> #second , self casesStatementAlternatives
		, ((comma , self othersStatement) ==> #second) optional , self endKeyword)
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]