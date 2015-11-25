pattern matching
matchIdentifier: aString
	^ [ :value | 
	Array
		with:
			(Dictionary new
				at: aString put: value;
				yourself) ]