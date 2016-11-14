private
evaluate: aString ifError: errorBlock
	^ selectedModule
		ifNil: [ animation plainEvaluate: aString ifError: errorBlock ]
		ifNotNil: [ :m | animation plainEvaluate: aString in: m ifError: errorBlock ]