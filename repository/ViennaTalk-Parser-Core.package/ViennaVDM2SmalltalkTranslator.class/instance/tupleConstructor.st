parsers-expressions-basics
tupleConstructor
	^ super tupleConstructor ==> [ :array | '{' , (' . ' join: array) , '}' ]