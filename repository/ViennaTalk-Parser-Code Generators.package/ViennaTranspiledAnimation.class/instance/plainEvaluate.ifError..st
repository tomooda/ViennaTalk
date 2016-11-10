evaluating
plainEvaluate: aString ifError: errorBlock
	^ self plainEvaluate: aString in: self defaultModule ifError: errorBlock