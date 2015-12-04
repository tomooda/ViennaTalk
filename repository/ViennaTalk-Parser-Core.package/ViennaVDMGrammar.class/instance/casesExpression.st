parsers-expressions-basics
casesExpression
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesExpressionAlternatives
		, ((comma , self othersExpression) ==> #second) optional , (self reserved: 'end'))
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]