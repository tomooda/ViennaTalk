evaluating
evaluateExpression: aString
	^ self evaluateExpression: aString ifError: [ :msg | self error: msg ]