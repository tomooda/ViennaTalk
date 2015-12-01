parsers-types
optionalType
	^ super optionalType ==> [ :basetype | basetype , ' optional' ]