parsers-expressions-operators
inverse: arg
	^ '([:dict :arg | arg keysAndValuesDo: [:k :v | dict at: v put: k]. dict] value: Dictionary new value: ' , arg , ')'