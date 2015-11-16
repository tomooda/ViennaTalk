parsers-expressions-type discriminations
isExpression
	^ (('is_' asParser , name , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ])
		/
			(('is_bool' asParser / 'is_nat' asParser / 'is_nat1' asParser / 'is_int' asParser / 'is_rat' asParser
				/ 'is_real' asParser / 'is_char' asParser / 'is_token' asParser , lparen , expression , rparen)
				==> [ :quatro | 
					{(quatro first copyFrom: 4 to: quatro first size).
					(quatro third)} ])