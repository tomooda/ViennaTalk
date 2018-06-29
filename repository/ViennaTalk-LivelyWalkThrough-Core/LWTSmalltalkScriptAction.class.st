Class {
	#name : #LWTSmalltalkScriptAction,
	#superclass : #LWTScriptAction,
	#instVars : [
		'performer',
		'compiledMethod'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LWTSmalltalkScriptAction class >> named: aString on: performer source: source notifying: requestor ifFail: errorBlock [
	^ self new
		setName: aString
			performer: performer
			source: source
			notifying: requestor
			ifFail: errorBlock;
		yourself
]

{ #category : #testing }
LWTSmalltalkScriptAction >> isSmalltalkScriptAction [
	^ true
]

{ #category : #private }
LWTSmalltalkScriptAction >> setName: nameString performer: anObject source: sourceString notifying: requestor ifFail: errorBlock [
	| compiler methodNode |
	self name: nameString.
	performer := anObject.
	source := sourceString.
	compiler := Compiler new.
	compiler
		from: source
		class: performer class
		context: nil
		notifying: requestor.
	methodNode := compiler translate: source readStream noPattern: true ifFail: [ ^ errorBlock value ].
	compiledMethod := compiler interactive
		ifTrue: [ methodNode generateWithSource ]
		ifFalse: [ methodNode generate ]
]

{ #category : #evaluating }
LWTSmalltalkScriptAction >> value [
	^ performer withArgs: #() executeMethod: compiledMethod
]
