private
setWidgetName: nameString event: eventString performer: anObject source: sourceString ifFail: errorBlock
	(self class scriptCompilerClass new
		compileToSmalltalk: sourceString
		ifError: [ :msg :pos | ^ errorBlock cull: msg cull: pos ])
		ifNotNil: [ :smalltalkSource | 
			| compiler methodNode |
			widgetName := nameString.
			event := eventString asSymbol.
			performer := anObject.
			compiler := Compiler new.
			compiler
				from: smalltalkSource
				class: performer class
				context: nil
				notifying: nil.
			methodNode := compiler translate: smalltalkSource readStream noPattern: true ifFail: [ ^ errorBlock value ].
			compiledMethod := compiler interactive
				ifTrue: [ methodNode generateWithSource ]
				ifFalse: [ methodNode generate ].
			source := sourceString ]