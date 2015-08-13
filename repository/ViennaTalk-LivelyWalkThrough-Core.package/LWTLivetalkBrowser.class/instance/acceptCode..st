code pane
acceptCode: aStringOrText
	aStringOrText asString ~= self code asString
		ifTrue: [ 
			| codeStream selector |
			codeStream := aStringOrText asString readStream.
			selector := (codeStream upTo: Character cr) trimmed.
			(LWTLivetalkScript
				named: selector
				on: self director
				source: codeStream upToEnd
				ifFail: [ 
					codePane flash.
					^ false ])
				ifNotNil: [ :script | 
					self director addScript: script.
					codePane hasUnacceptedEdits: false.
					self changed: #scriptList.
					self selectScriptNamed: selector.
					^ true ] ]