parsers-types
type
	^ basicType / quoteType / compositeType / unionType / productType / optionalType / setType / seqType / mapType
		/ partialFunctionType / typeName / typeVariable
		/ (($( asParser trim , type , $) asParser trim) ==> [ :triple | triple second ])