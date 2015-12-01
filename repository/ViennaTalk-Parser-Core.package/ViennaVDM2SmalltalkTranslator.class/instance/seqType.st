parsers-types
seqType
	^ super seqType ==> [ :basetype | basetype , ' seq' ]