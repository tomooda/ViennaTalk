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

{ #category : #'instance creation' }
LWTDirector class >> default [
	^ self on: VDMC default
]

{ #category : #'instance creation' }
LWTDirector class >> on: aVDMC [
	^ self new vdmc: aVDMC
]

{ #category : #'instance creation' }
LWTDirector class >> vdmj [
	^ self on: VDMC vdmj
]

{ #category : #dialogs }
LWTDirector >> abort: aString [
	| context |
	context := thisContext.
	[ context receiver isKindOf: LWTAction ] whileFalse: [ context := context sender ].
	UIManager default abort: aString title: 'Lively Walk-Through: ' , context receiver name.
	context return: nil
]

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

{ #category : #defaults }
LWTDirector >> defaultVDMC [
	^ VDMC vdmj
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

{ #category : #interpreting }
LWTDirector >> execCall: aString [
	^ self dispatchActionAt: aString asSymbol ifAbsent: [ self abort: 'Can not read an undefined variable: ' , aString ]
]

{ #category : #interpreting }
LWTDirector >> execDialog: aString [
	self inform: aString
]

{ #category : #interpreting }
LWTDirector >> execLet: aString be: anObject [
	(self morphNamed: aString ifAbsent: [ self abort: 'Can not assign to an undefined variable: ' , aString ])
		value: anObject.
	^ anObject
]

{ #category : #interpreting }
LWTDirector >> execVDM: aString withArguments: anArray [
	^ aString , '(' , (',' join: anArray)
		in: [ :expression | 
			| value |
			value := self vdmc plainEvaluate: expression.
			self addFrame: (LWTVDMCallFrame callee: aString expression: expression value: value).
			self addFrame: (LWTVDMStateFrame states: self vdmc state).
			value ]
]

{ #category : #interpreting }
LWTDirector >> execValueOf: aString [
	^ (self morphNamed: aString ifAbsent: [ self abort: 'Can not read an undefined variable: ' , aString ]) value
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
LWTDirector >> inform: aString [
	| context |
	context := thisContext.
	[ context receiver isKindOf: LWTAction ] whileFalse: [ context := context sender ].
	UIManager default alert: aString title: 'Lively Walk-Through: ' , context receiver name
]

{ #category : #'initialize-release' }
LWTDirector >> initialize [
	super initialize.
	actions := Dictionary new.
	frames := Array new writeStream.
	lastFrame := nil.
	cuts := Dictionary new
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
	^ self vdmc specification
]

{ #category : #accessing }
LWTDirector >> specification: aString [
	self vdmc specification: aString
]

{ #category : #'accessing-morphs' }
LWTDirector >> valueOf: aString ifAbsent: errorBlock [
	self morphsNamed: aString do: [ :morph | ^ morph value ].
	^ errorBlock value
]

{ #category : #accessing }
LWTDirector >> vdmc [
	^ vdmc ifNil: [ vdmc := self defaultVDMC ]
]

{ #category : #accessing }
LWTDirector >> vdmc: aVDMC [
	vdmc
		ifNotNil: [ 
			aVDMC specification: vdmc specification.
			vdmc state keysAndValuesDo: [ :key :value | aVDMC plainAt: key put: value ] ].
	vdmc := aVDMC
]

{ #category : #'event handling' }
LWTDirector >> wantsDroppedMorph: aMorph event: aMouseEvent [
	^ true
]
