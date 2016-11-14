evaluating
plainEvaluate: aString
	^ self plainEvaluate: aString ifError: [ :msg | Error signal: msg ]