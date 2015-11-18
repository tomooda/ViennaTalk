parsers-expressions-basics
setEnumeration
	^ super setEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asSet' ]