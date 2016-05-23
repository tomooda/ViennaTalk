parsers-types
type3
	^ self mapType / self inmapType / self setType / self set1Type / self seqType / self seq1Type / self basicType / self quoteType / self compositeType / self optionalType / self typeName
		/ self typeVariable / ((lparen , type , rparen) ==> #second)