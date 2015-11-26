pattern matching
matchIdentifier: aStringOrNil
	^ [ :value | 
	aStringOrNil
		ifNil: [ Array with: Dictionary new ]
		ifNotNil: [ 
			Array
				with:
					(Dictionary new
						at: aStringOrNil put: value;
						yourself) ] ]