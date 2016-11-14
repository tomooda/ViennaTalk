evaluating
plainEvaluate: aString in: moduleName ifError: errorBlock
	| result |
	result := writer
		stringify: (self evaluate: aString in: moduleName ifError: [ :msg | ^ errorBlock value: msg ]).
	^ result