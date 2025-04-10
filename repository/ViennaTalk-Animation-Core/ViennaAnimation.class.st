Class {
	#name : #ViennaAnimation,
	#superclass : #Model,
	#instVars : [
		'lock',
		'engine',
		'specification',
		'state',
		'reader',
		'writer',
		'usesExceptionForExit'
	],
	#category : #'ViennaTalk-Animation-Core'
}

{ #category : #'instance creation' }
ViennaAnimation class >> client [
	^ self new
		engine: ViennaClient default;
		yourself
]

{ #category : #'instance creation' }
ViennaAnimation class >> default [

	Smalltalk
		at: #ViennaTranspiledAnimation
		ifPresent: [ :class |
		class useTranspilerByDefault ifTrue: [ ^ self transpiler ] ].
	^ self interpreter
]

{ #category : #examples }
ViennaAnimation class >> exampleFibonacci [
	"ViennaAnimation exampleFibonacci"

	| animation |
	animation := ViennaAnimation default.
	animation
		specification:
			'
state State of
	n1 : nat
	n2 : nat
	init s == s = mk_State(0, 1)
end
operations
	next : () ==> nat
	next() == (dcl n : nat := n1 + n2; n1 := n2; n2 := n; return n);'.
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (animation evaluate: 'next()') ] ]) inspect; yourself
]

{ #category : #examples }
ViennaAnimation class >> exampleFibonacciLocal [
	"ViennaAnimation exampleFibonacciLocal"

	| animation |
	animation := ViennaAnimation vdmj.
	animation
		specification:
			'
state State of
	n1 : nat
	n2 : nat
	init s == s = mk_State(0, 1)
end
operations
	next : () ==> nat
	next() == (dcl n : nat := n1 + n2; n1 := n2; n2 := n; return n);'.
	^ (Array
		streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (animation evaluate: 'next()') ] ])
		inspect;
		yourself
]

{ #category : #'instance creation' }
ViennaAnimation class >> interpreter [

	^ self new
		  engine: ViennaEngine default;
		  yourself
]

{ #category : #'instance creation' }
ViennaAnimation class >> on: aViennaEngine [
	^ self new
		engine: aViennaEngine;
		yourself
]

{ #category : #'instance creation' }
ViennaAnimation class >> url: aStringOrUrl [
	^ self new
		engine: (ViennaClient on: aStringOrUrl);
		yourself
]

{ #category : #'instance creation' }
ViennaAnimation class >> vdmj [
	^ self new
		engine: ViennaVDMJ new;
		yourself
]

{ #category : #announcement }
ViennaAnimation >> announceSpecificationChanged [

	self announcer announce: (ViennaSpecificationChanged new
			 animation: self;
			 yourself)
]

{ #category : #announcement }
ViennaAnimation >> announceStateChanged [

	self announcer announce: (ViennaStateChanged new
			 animation: self;
			 yourself)
]

{ #category : #converting }
ViennaAnimation >> asInterpretedAnimation [
	^ self
]

{ #category : #accessing }
ViennaAnimation >> at: aString [
	^ self
		at: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]
]

{ #category : #accessing }
ViennaAnimation >> at: aString ifAbsent: errorBlock [
	^ self at: aString ifPresent: [ :value | value ] ifAbsent: errorBlock
]

{ #category : #accessing }
ViennaAnimation >> at: aString ifAbsentPut: errorBlock [

	^ self at: aString ifPresent: [ :value | value ] ifAbsent: [
		  state at: aString put: (writer stringify: errorBlock value).
		  self announceStateChanged ]
]

{ #category : #accessing }
ViennaAnimation >> at: aString ifPresent: errorBlock [
	^ self at: aString ifPresent: errorBlock ifAbsent: [  ]
]

{ #category : #accessing }
ViennaAnimation >> at: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ state at: aString ifPresent: [ :value | aBlock cull: (reader parseOn: value readStream) ] ifAbsent: errorBlock
]

{ #category : #accessing }
ViennaAnimation >> at: aString put: anObject [
	^ state at: aString put: (writer stringify: anObject)
]

{ #category : #evaluating }
ViennaAnimation >> basicPlainEvaluate: aString in: moduleName ifError: errorBlock [

	Cursor wait showWhile: [
		| preState result postState |
		preState := Dictionary new.
		state keysAndValuesDo: [ :key :value |
			| module var |
			(key includes: $`)
				ifTrue: [
					| index |
					index := key indexOf: $`.
					module := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size ]
				ifFalse: [
					module := self defaultModule.
					var := key ].
			(preState at: module ifAbsentPut: [ Dictionary new ])
				at: var
				put: value ].
		result := engine
			          evaluate: aString
			          specification: self specification
			          states: preState
			          module: moduleName.
		result third ifNotEmpty: [ :msg | ^ errorBlock value: msg ].
		postState := Dictionary new.
		result second keysAndValuesDo: [ :module :binds |
			binds keysAndValuesDo: [ :var :value |
				postState
					at: (var = self defaultModule
							 ifTrue: [ var ]
							 ifFalse: [ module , '`' , var ])
					put: value ] ].
		state := postState.
		self announceStateChanged.
		^ result first ]
]

{ #category : #private }
ViennaAnimation >> becomeInterpretedAnimation [
	^ self
]

{ #category : #converting }
ViennaAnimation >> copyForTest [
	^ self copy
]

{ #category : #defaults }
ViennaAnimation >> defaultModule [
	^ 'DEFAULT'
]

{ #category : #accessing }
ViennaAnimation >> engine [
	^ engine
]

{ #category : #accessing }
ViennaAnimation >> engine: aViennaEngine [
	engine := aViennaEngine
]

{ #category : #accessing }
ViennaAnimation >> engineType [
	^ #interpreter
]

{ #category : #evaluating }
ViennaAnimation >> evaluate: aString [
	^ reader parseOn: (self plainEvaluate: aString) readStream
]

{ #category : #evaluating }
ViennaAnimation >> init [

	lock critical: [
		| result postState |
		result := engine
			          evaluate: String new
			          specification: self specification
			          states: Dictionary new.
		result third ifNotEmpty: [ :msg | ^ Error signal: msg ].
		postState := Dictionary new.
		result second keysAndValuesDo: [ :module :binds |
			binds keysAndValuesDo: [ :var :value |
				postState
					at: (var = self defaultModule
							 ifTrue: [ var ]
							 ifFalse: [ module , '`' , var ])
					put: value ] ].
		state := postState.
		self announceStateChanged ]
]

{ #category : #'initialize-release' }
ViennaAnimation >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion.
	specification := String new.
	state := Dictionary new.
	reader := ViennaReader new.
	writer := ViennaWriter new
]

{ #category : #testing }
ViennaAnimation >> isTranspiledAnimation [

	^ false
]

{ #category : #private }
ViennaAnimation >> parseJson: aJsonString [
	^ NeoJSONReader fromString: aJsonString
]

{ #category : #'accessing-plain' }
ViennaAnimation >> plainAt: aString [
	^ self
		plainAt: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]
]

{ #category : #'accessing-plain' }
ViennaAnimation >> plainAt: aString ifAbsent: errorBlock [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: errorBlock
]

{ #category : #'accessing-plain' }
ViennaAnimation >> plainAt: aString ifAbsentPut: errorBlock [

	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [
		  state at: aString put: errorBlock value.
		  self announceStateChanged ]
]

{ #category : #'accessing-plain' }
ViennaAnimation >> plainAt: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ state at: aString ifPresent: [ :value | aBlock cull: value ] ifAbsent: errorBlock
]

{ #category : #'accessing-plain' }
ViennaAnimation >> plainAt: aString put: anObject [

	state at: aString put: anObject.
	self announceStateChanged.
	^ anObject
]

{ #category : #evaluating }
ViennaAnimation >> plainEvaluate: aString [
	^ self plainEvaluate: aString ifError: [ :msg | Error signal: msg ]
]

{ #category : #evaluating }
ViennaAnimation >> plainEvaluate: aString ifError: errorBlock [
	^ self plainEvaluate: aString in: self defaultModule ifError: errorBlock
]

{ #category : #evaluating }
ViennaAnimation >> plainEvaluate: aString in: moduleName ifError: errorBlock [

	| result |
	lock critical: [
		result := self
			          basicPlainEvaluate: aString
			          in: (moduleName ifNil: [ self defaultModule ])
			          ifError: [ :msg | ^ errorBlock cull: msg ] ].
	self changed: #state.
	^ result
]

{ #category : #evaluating }
ViennaAnimation >> plainExecute: aViennaNode in: moduleName ifError: errorBlock [

	^ self
		  plainEvaluate: aViennaNode source
		  in: moduleName
		  ifError: errorBlock
]

{ #category : #copying }
ViennaAnimation >> postCopy [
	| oldSpec oldState |
	super postCopy.
	oldSpec := self specification.
	oldState := self state.
	announcer := nil.
	dependents := nil.
	self initialize.
	self specification: oldSpec.
	self state: oldState
]

{ #category : #accessing }
ViennaAnimation >> reader [
	^ reader
]

{ #category : #accessing }
ViennaAnimation >> reader: aViennaReader [
	reader := aViennaReader
]

{ #category : 'evaluating' }
ViennaAnimation >> runTestOperation: operation module: module [

	| header |
	header := 'Runtime: Error 4129: Exit '.
	self plainEvaluate: operation , '()' in: module ifError: [ :msg |
		(msg size > header size and: [
			 (msg copyFrom: 1 to: header size) = header ])
			ifTrue: [
				ViennaException signal:
					(ViennaReader new parse:
						 (msg copyFrom: header size + 1 to: msg size)) ]
			ifFalse: [ Error signal: msg ] ]
]

{ #category : 'accessing' }
ViennaAnimation >> specification [
	^ specification
]

{ #category : #accessing }
ViennaAnimation >> specification: aString [

	specification := aString.
	self changed: #specification.
	self announceSpecificationChanged
]

{ #category : #accessing }
ViennaAnimation >> specification: aStringOrViennaNode ifError: errorBlock [

	| source |
	source := aStringOrViennaNode isViennaNode
		          ifTrue: [ aStringOrViennaNode source ]
		          ifFalse: [ aStringOrViennaNode asString ].
	specification ~= source ifTrue: [
		| oldState |
		lock critical: [
			| oldSpec |
			oldSpec := specification.
			oldState := state copy.
			specification := source.
			self
				basicPlainEvaluate: 'nil'
				in: self defaultModule
				ifError: [ :msg |
					specification := oldSpec.
					^ errorBlock cull: msg ] ].
		self changed: #specification.
		self announceSpecificationChanged.
		oldState ~= state ifTrue: [
			self changed: #state.
			self announceStateChanged ] ]
]

{ #category : #private }
ViennaAnimation >> state [
	^ state copy
]

{ #category : #accessing }
ViennaAnimation >> state: aDictionary [

	state := aDictionary copy.
	self announceStateChanged
]

{ #category : #private }
ViennaAnimation >> stringify: aJsonObject [
	^ String streamContents: [ :stream |
			(NeoJSONWriter on: stream) asciiOnly: true; nextPut: aJsonObject ]

]

{ #category : #accessing }
ViennaAnimation >> writer [
	^ writer
]

{ #category : #accessing }
ViennaAnimation >> writer: aViennaWriter [
	writer := aViennaWriter
]
