Class {
	#name : 'LWTLivetalkScript',
	#superclass : 'Object',
	#instVars : [
		'widgetName',
		'event',
		'source',
		'performer',
		'compiledMethod'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'instance creation' }
LWTLivetalkScript class >> named: aString on: performer source: source ifFail: errorBlock [
	| nameString widgetName event |
	nameString := aString trimmed.
	(nameString findLastOccurrenceOfString: '`' startingAt: 1)
		in: [ :index | 
			index = 0
				ifTrue: [ ^ errorBlock cull: 'Invalid name: name should be in the form of widgetName`event.' ].
			widgetName := nameString copyFrom: 1 to: index - 1.
			event := nameString copyFrom: index + 1 to: nameString size ].
	^ self new
		setWidgetName: widgetName
			event: event
			performer: performer
			source: source
			ifFail: errorBlock;
		yourself
]

{ #category : 'class access' }
LWTLivetalkScript class >> scriptCompilerClass [
	^ LWTLivetalkCompiler
]

{ #category : 'printing' }
LWTLivetalkScript >> displayString [
	^ source copy
]

{ #category : 'accessing' }
LWTLivetalkScript >> event [
	^ event
]

{ #category : 'testing' }
LWTLivetalkScript >> isLivetalkScriptAction [
	^ true
]

{ #category : 'accessing' }
LWTLivetalkScript >> name [
	^ widgetName , '`' , event
]

{ #category : 'private' }
LWTLivetalkScript >> setWidgetName: nameString event: eventString performer: anObject source: sourceString ifFail: errorBlock [
	(self class scriptCompilerClass new
		compileToSmalltalk: sourceString
		ifError: [ :msg :pos | ^ errorBlock cull: msg cull: pos ])
		ifNotNil: [ :smalltalkSource | 
			| compiler  |
			widgetName := nameString.
			event := eventString asSymbol.
			performer := anObject.
			compiler := OpalCompiler new
				source: smalltalkSource;
				class: performer class;
				noPattern: true;
				failBlock: [ ^ errorBlock value ].
			compiledMethod := compiler compile.
			source := sourceString ]
]

{ #category : 'accessing' }
LWTLivetalkScript >> source [
	^ source copy
]

{ #category : 'accessing' }
LWTLivetalkScript >> source: aString [
	source := aString
]

{ #category : 'evaluating' }
LWTLivetalkScript >> value [
	^ performer withArgs: #() executeMethod: compiledMethod
]

{ #category : 'accessing' }
LWTLivetalkScript >> widgetName [
	^ widgetName
]
