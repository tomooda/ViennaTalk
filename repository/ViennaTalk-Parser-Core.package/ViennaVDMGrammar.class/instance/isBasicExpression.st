parsers-expressions-type discriminations
isBasicExpression
	^ ('is_bool' asParser / 'is_nat' asParser / 'is_nat1' asParser / 'is_int' asParser / 'is_rat' asParser
		/ 'is_real' asParser / 'is_char' asParser / 'is_token' asParser , lparen , expression , rparen)
		==> [ :quatro | 
			{(quatro first copyFrom: 4 to: quatro first size).
			(quatro third)} ]