parsers-expressions-basics
casesExpression
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesExpressionAlternatives
		, ((comma , others , (self operator: '->') , expression) ==> #fourth) optional , end)
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]