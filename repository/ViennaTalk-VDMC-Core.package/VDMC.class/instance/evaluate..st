evaluating
evaluate: aString
	^ reader parseOn: (self plainEvaluate: aString) readStream