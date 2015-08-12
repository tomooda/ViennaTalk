code pane
acceptCode: aStringOrText
	aStringOrText asString ~= self code asString
		ifTrue: [ 
			| codeStream selector |
			codeStream := aStringOrText asString readStream.
			selector := (codeStream upTo: Character cr) trimmed.
			(LWTLivetalkScriptAction
				named: selector
				on: self director
				source: codeStream upToEnd
				notifying: codePane
				ifFail: [ 
					codePane flash.
					nil ])
				ifNil: [ ^ false ]
				ifNotNil: [ :action | 
					self director actionAt: selector asSymbol put: action.
					codePane hasUnacceptedEdits: false.
					self changed: #actionList.
					self selectActionNamed: selector.
					^ true ] ]