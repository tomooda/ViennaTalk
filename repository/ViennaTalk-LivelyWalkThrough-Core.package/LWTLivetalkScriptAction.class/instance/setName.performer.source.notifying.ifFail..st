private
setName: nameString performer: anObject source: sourceString notifying: requestor ifFail: errorBlock
	(self class scriptCompilerClass new compileToSmalltalk: sourceString requestor: requestor)
		ifNil: errorBlock
		ifNotNil: [ :smalltalkSource | 
			super
				setName: nameString
				performer: anObject
				source: smalltalkSource
				notifying: requestor
				ifFail: errorBlock.
			source := sourceString ]