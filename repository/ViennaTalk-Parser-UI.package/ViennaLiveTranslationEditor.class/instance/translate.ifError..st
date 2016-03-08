accessing
translate: aTextOrString ifError: errorBlock
	^ (self translator value: aTextOrString asString)
		in: [ :result | 
			result isPetitFailure
				ifTrue: [ errorBlock value: result ]
				ifFalse: [ self format: result ] ]