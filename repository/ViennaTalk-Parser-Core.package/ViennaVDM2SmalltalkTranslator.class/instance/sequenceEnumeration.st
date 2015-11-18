parsers-expressions-basics
sequenceEnumeration
	^ super sequenceEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asOrderedCollection' ]