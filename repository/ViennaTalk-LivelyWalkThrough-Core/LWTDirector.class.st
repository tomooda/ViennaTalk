Class {
	#name : #LWTDirector,
	#superclass : #Morph,
	#instVars : [
		'actions',
		'vdmc',
		'frames',
		'lastFrame',
		'cuts'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'accessing-actions' }
LWTDirector >> actionAt: aSymbol ifAbsent: errorBlock [
	^ actions at: aSymbol asSymbol ifAbsent: errorBlock
]

{ #category : #'accessing-actions' }
LWTDirector >> actionAt: aSymbol put: anLWTAction [
	^ actions at: aSymbol asSymbol put: anLWTAction
]

{ #category : #'accessing-actions' }
LWTDirector >> actionSelectors [
	^ actions keys asSortedCollection asArray
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> addFrame: anLWTFrame [
	frames nextPut: anLWTFrame.
	lastFrame := anLWTFrame
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> clearFrames [
	frames := Array new writeStream.
	lastFrame := nil
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> cutAt: aString [
	^ aString
		ifNotNil: [ 
			cuts
				at: aString
				ifAbsentPut: [ 
					LWTCut new
						addFrames: frames contents;
						yourself ] ]
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> cutAt: aString ifAbsent: errorBlock [
	^ aString ifNotNil: [ cuts at: aString ifAbsent: errorBlock ]
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> cutAt: aString put: anLWTCut [
	^ aString ifNotNil: [ anLWTCut ifNotNil: [ cuts at: aString put: anLWTCut ] ]
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> cutNames [
	^ cuts keys asSortedCollection
]

{ #category : #'accessing-actions' }
LWTDirector >> dispatchActionAt: aSymbol ifAbsent: errorBlock [
	^ (actions at: aSymbol asSymbol ifAbsent: [  ]) ifNotNilDo: [ :action | action value: self ] ifNil: errorBlock
]

{ #category : #drawing }
LWTDirector >> drawOn: aCanvas [
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color white
		borderWidth: 0
		borderColor: Color white
]

{ #category : #dialogs }
LWTDirector >> error: aString actionName: nameString [
	| context |
	UIManager default abort: aString title: 'Lively Walk-Through: ' , nameString.
	context := thisContext.
	[ context receiver isKindOf: LWTAction ] whileFalse: [ context := context sender ].
	context return: nil
]

{ #category : #interpreting }
LWTDirector >> execCall: aString [
	| name |
	name := thisContext sender name.
	^ self
		dispatchActionAt: aString asSymbol
		ifAbsent: [ self error: 'Can not read an undefined variable: ' , aString actionName: name ]
]

{ #category : #interpreting }
LWTDirector >> execDialog: aString [
	self inform: aString actionName: thisContext sender receiver name
]

{ #category : #interpreting }
LWTDirector >> execLet: aString be: anObject [
	| name |
	name := thisContext sender name.
	(self
		morphNamed: aString
		ifAbsent: [ self error: 'Can not assign to an undefined variable: ' , aString actionName: name ]) value: anObject.
	^ anObject
]

{ #category : #interpreting }
LWTDirector >> execVDM: aString withArguments: anArray [
	^ aString , '(' , (',' join: anArray)
		in: [ :expression | 
			| value |
			value := vdmc plainEvaluate: expression.
			self addFrame: (LWTVDMCallFrame callee: aString expression: expression value: value).
			self addFrame: (LWTVDMStateFrame states: vdmc state).
			value ]
]

{ #category : #interpreting }
LWTDirector >> execValueOf: aString [
	| name |
	name := thisContext sender name.
	^ (self
		morphNamed: aString
		ifAbsent: [ self error: 'Can not read an undefined variable: ' , aString actionName: name ]) value
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> frames [
	^ frames contents
]

{ #category : #'event handling' }
LWTDirector >> handlesMouseDown: aMouseEvent [
	^ false
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> hasProceededSince: anLWTFrame [
	^ lastFrame ~~ anLWTFrame
]

{ #category : #dialogs }
LWTDirector >> inform: aString actionName: nameString [
	UIManager default proceed: aString title: 'Lively Walk-Through: ' , nameString
]

{ #category : #'initialize-release' }
LWTDirector >> initialize [
	super initialize.
	actions := Dictionary new.
	frames := Array new writeStream.
	lastFrame := nil.
	cuts := Dictionary new.
	vdmc := VDMC vdmj
]

{ #category : #'accessing-morphs' }
LWTDirector >> let: aString be: anObject ifAbsentDo: errorBlock [
	^ self morphsNamed: aString ifNotEmpty: [ :morph | morph value: anObject ] ifEmpty: [ errorBlock value: anObject ]
]

{ #category : #'accessing-morphs' }
LWTDirector >> morphNamed: aString ifAbsent: errorBlock [
	self morphsNamed: aString do: [ :morph | ^morph ].
	^ errorBlock value
]

{ #category : #'accessing-morphs' }
LWTDirector >> morphsNamed: aString do: aBlock [
	self
		allMorphsDo: [ :submorph | 
			submorph name = aString
				ifTrue: [ aBlock value: submorph ] ]
]

{ #category : #'accessing-morphs' }
LWTDirector >> morphsNamed: aString ifNotEmpty: aBlock ifEmpty: errorBlock [
	| any |
	any := false.
	self
		morphsNamed: aString
		do: [ :submorph | 
			aBlock value: submorph.
			any := any or: [ true ] ].
	any
		ifFalse: [ errorBlock value ]
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> recordEvent: aSymbol at: aMorph [
	self addFrame: (LWTEventFrame morphName: aMorph name event: aSymbol)
]

{ #category : #'accessing-actions' }
LWTDirector >> removeActionAt: aSymbol ifAbsent: errorBlock [
	^ actions removeKey: aSymbol asSymbol ifAbsent: errorBlock
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> removeCutAt: aString [
	^ cuts removeKey: aString ifAbsent: [  ]
]

{ #category : #accessing }
LWTDirector >> specification [
	^ vdmc specification
]

{ #category : #accessing }
LWTDirector >> specification: aString [
	vdmc specification: aString
]

{ #category : #'accessing-morphs' }
LWTDirector >> valueOf: aString ifAbsent: errorBlock [
	self morphsNamed: aString do: [ :morph | ^ morph value ].
	^ errorBlock value
]

{ #category : #accessing }
LWTDirector >> vdmc [
	^ vdmc
]

{ #category : #'event handling' }
LWTDirector >> wantsDroppedMorph: aMorph event: aMouseEvent [
	^ true
]
