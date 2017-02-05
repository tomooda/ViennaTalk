parsers-definitions
implicitOperationBody
	^ self externals optional , ((self pre , expression) ==> #second) optional
		, ((self post , expression) ==> #second) , self exceptions optional