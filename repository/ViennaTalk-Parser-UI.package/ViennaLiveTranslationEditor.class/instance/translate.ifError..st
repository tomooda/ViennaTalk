accessing
translate: aTextOrString ifError: errorBlock
	^ (self translator parse: aTextOrString asString)
		in: [ :result | 
			result isPetitFailure
				ifTrue: [ errorBlock value: result ]
				ifFalse: [ self format: result ] ]