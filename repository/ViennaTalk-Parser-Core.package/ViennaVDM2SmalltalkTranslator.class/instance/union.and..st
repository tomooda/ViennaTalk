parsers-expressions-operators
union: arg1 and: arg2
	^ '(' , arg1 , ' copy addAll: ' , arg2 , '; yourself)'