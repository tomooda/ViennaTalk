evaluating
plainEvaluate: aString
	^ self plainEvaluate: aString ifError: [ :msg | self error: msg ]