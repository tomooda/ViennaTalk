private
evaluate: aString ifError: errorBlock
	^ selectedModule
		ifNil: [ vdmc plainEvaluate: aString ifError: errorBlock ]
		ifNotNil: [ :m | vdmc plainEvaluate: aString in: m ifError: errorBlock ]