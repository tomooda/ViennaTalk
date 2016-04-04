parsers-expressions-type discriminations
isBasicExpression
	^ ('is_' asParser , self basicTypeName , lparen , expression , rparen)
		==> [ :quatro | 
			{(quatro first copyFrom: 4 to: quatro first size).
			(quatro third)} ]