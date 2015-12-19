parsers-expressions
setEnumeration
	^ super sequenceEnumeration ==> [ :elems | elems asSet ]