Class {
	#name : #LWTDirector,
	#superclass : #Morph,
	#instVars : [
		'vdmc',
		'frames',
		'lastFrame',
		'cuts',
		'scripts',
		'dependents'
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

{ #category : #dependents }
LWTDirector >> actAsExecutor [
	super actAsExecutor.
	self breakDependents
]

{ #category : #dependents }
LWTDirector >> addDependent: anObject [
	(self dependents includes: anObject)
		ifFalse: [ self myDependents: (self dependents copyWithDependent: anObject) ].
	^ anObject
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> addFrame: anLWTFrame [
	frames nextPut: anLWTFrame.
	lastFrame := anLWTFrame
]

{ #category : #'accessing-scripts' }
LWTDirector >> addScript: aLWTLivetalkScript [
	^ (scripts at: aLWTLivetalkScript widgetName ifAbsentPut: [ Dictionary new ])
		at: aLWTLivetalkScript event
		put: aLWTLivetalkScript
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

{ #category : #drawing }
LWTDirector >> drawOn: aCanvas [
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color white
		borderWidth: 0
		borderColor: Color white
]

{ #category : #interpreting }
LWTDirector >> execDialog: aString [
	self inform: aString
]

{ #category : #interpreting }
LWTDirector >> execEvent: eventName at: widgetName [
	^ ((scripts at: widgetName ifAbsent: [ ^ self ]) at: eventName ifAbsent: [ ^ self ]) value
]

{ #category : #interpreting }
LWTDirector >> execLet: aString be: anObject [
	(self morphNamed: aString ifAbsent: [ self abort: 'Can not assign to an undefined variable: ' , aString ])
		value: anObject.
	^ anObject
]

{ #category : #interpreting }
LWTDirector >> execVDM: aString withArguments: anArray [
	^ aString , '(' , (',' join: anArray), ')'
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
	[ context receiver isKindOf: LWTLivetalkScript ] whileFalse: [ context := context sender ].
	UIManager default alert: aString title: 'Lively Walk-Through: ' , context receiver name
]

{ #category : #'initialize-release' }
LWTDirector >> initialize [
	super initialize.
	scripts := Dictionary new.
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

{ #category : #private }
LWTDirector >> myDependents [
	^ dependents
]

{ #category : #private }
LWTDirector >> myDependents: aCollectionOrNil [
	dependents := aCollectionOrNil
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> recordEvent: aSymbol at: aMorph [
	self addFrame: (LWTEventFrame morphName: aMorph name event: aSymbol)
]

{ #category : #'accessing-frames and cuts' }
LWTDirector >> removeCutAt: aString [
	^ cuts removeKey: aString ifAbsent: [  ]
]

{ #category : #dependents }
LWTDirector >> removeDependent: anObject [
	self myDependents: ((self dependents reject: [ :each | each == anObject ]) ifNotEmpty: #yourself).
	^ anObject
]

{ #category : #'accessing-scripts' }
LWTDirector >> removeScriptAt: aString ifAbsent: errorBlock [
	self
		scriptsDo: [ :script | 
			script name = aString
				ifTrue: [ 
					(scripts at: script widgetName) removeKey: script event.
					^ script ] ].
	^ errorBlock value
]

{ #category : #'accessing-scripts' }
LWTDirector >> scriptAt: aString ifAbsent: errorBlock [
	self
		scriptsDo: [ :script | 
			script name = aString
				ifTrue: [ ^ script ] ].
	^ errorBlock value
]

{ #category : #'accessing-scripts' }
LWTDirector >> scriptSelectors [
	^ (Array new: 10 streamContents: [ :stream | self scriptsDo: [ :script | stream nextPut: script name ] ])
		asSortedCollection
]

{ #category : #private }
LWTDirector >> scriptsDo: aBlock [
	scripts valuesDo: [ :scriptDict | scriptDict valuesDo: aBlock ]
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
