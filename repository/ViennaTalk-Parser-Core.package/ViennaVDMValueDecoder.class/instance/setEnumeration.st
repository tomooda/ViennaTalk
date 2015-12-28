parsers-expressions
setEnumeration
	^ super setEnumeration ==> [ :elems | elems asSet ]