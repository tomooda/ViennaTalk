parsers-literals
symbolicLiteral
	^ (comment star
		,
			(self numericLiteral / self booleanLiteral / self nilLiteral / self characterLiteral / self textLiteral
				/ self quoteLiteral) , comment star) ==> #second