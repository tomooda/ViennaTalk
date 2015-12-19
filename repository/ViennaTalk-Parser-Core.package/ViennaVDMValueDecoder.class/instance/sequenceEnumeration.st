parsers-expressions
sequenceEnumeration
	^ super sequenceEnumeration ==> [ :elems | elems asOrderedCollection ]