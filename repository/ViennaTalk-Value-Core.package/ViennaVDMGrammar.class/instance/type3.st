parsers-types
type3
	^ mapType / inmapType / setType / seqType / seq1Type / basicType / quoteType / compositeType / optionalType / typeName
		/ typeVariable / (($( asParser trim , type , $) asParser trim) ==> [ :triple | triple second ])