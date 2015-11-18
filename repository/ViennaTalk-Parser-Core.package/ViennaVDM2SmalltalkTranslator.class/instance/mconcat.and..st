parsers-expressions-operators
mconcat: arg1 and: arg2
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'