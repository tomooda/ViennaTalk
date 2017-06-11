evaluating
evaluateStatement: aString
	^ self evaluateStatement: aString ifError: [ :msg | self error: msg ]