Class {
	#name : #LWTLivetalkScriptAction,
	#superclass : #LWTSmalltalkScriptAction,
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'class access' }
LWTLivetalkScriptAction class >> scriptCompilerClass [
	^ LWTLivetalkCompiler
]

{ #category : #testing }
LWTLivetalkScriptAction >> isLivetalkScriptAction [
	^ true
]

{ #category : #private }
LWTLivetalkScriptAction >> setName: nameString performer: anObject source: sourceString notifying: requestor ifFail: errorBlock [
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
]
