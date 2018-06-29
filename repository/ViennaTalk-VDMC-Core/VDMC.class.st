Class {
	#name : #VDMC,
	#superclass : #Object,
	#instVars : [
		'lock',
		'engine',
		'specification',
		'state',
		'reader',
		'writer'
	],
	#category : 'ViennaTalk-VDMC-Core'
}

{ #category : #'instance creation' }
VDMC class >> default [
	^ self new
		engine: ViennaClient default;
		yourself
]

{ #category : #examples }
VDMC class >> exampleFibonacci [
	"VDMC exampleFibonacci"

	| vdmc |
	vdmc := VDMC default.
	vdmc
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
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (vdmc evaluate: 'next()') ] ]) inspect; yourself
]

{ #category : #examples }
VDMC class >> exampleFibonacciLocal [
	"VDMC exampleFibonacciLocal"

	| vdmc |
	vdmc := VDMC vdmj.
	vdmc
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
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (vdmc evaluate: 'next()') ] ]) inspect; yourself
]

{ #category : #'instance creation' }
VDMC class >> on: aViennaEngine [
	^ self new
		engine: aViennaEngine;
		yourself
]

{ #category : #'instance creation' }
VDMC class >> url: aStringOrUrl [
	^ self new
		engine: (ViennaClient on: aStringOrUrl);
		yourself
]

{ #category : #'instance creation' }
VDMC class >> vdmj [
	^ self new
		engine: ViennaVDMJ new;
		yourself
]

{ #category : #accessing }
VDMC >> at: aString [
	^ self
		at: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]
]

{ #category : #accessing }
VDMC >> at: aString ifAbsent: errorBlock [
	^ self at: aString ifPresent: [ :value | value ] ifAbsent: errorBlock
]

{ #category : #accessing }
VDMC >> at: aString ifAbsentPut: errorBlock [
	^ self
		at: aString
		ifPresent: [ :value | value ]
		ifAbsent: [ state at: aString put: (writer stringify: errorBlock value) ]
]

{ #category : #accessing }
VDMC >> at: aString ifPresent: errorBlock [
	^ self at: aString ifPresent: errorBlock ifAbsent: [  ]
]

{ #category : #accessing }
VDMC >> at: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ state at: aString ifPresent: [ :value | aBlock cull: (reader parseOn: value readStream) ] ifAbsent: errorBlock
]

{ #category : #accessing }
VDMC >> at: aString put: anObject [
	^ state at: aString put: (writer stringify: anObject)
]

{ #category : #defaults }
VDMC >> defaultUrl [
	^ 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl
]

{ #category : #accessing }
VDMC >> engine [
	^ engine
]

{ #category : #accessing }
VDMC >> engine: aViennaEngine [
	engine := aViennaEngine
]

{ #category : #evaluating }
VDMC >> evaluate: aString [
	^ reader parseOn: (self plainEvaluate: aString) readStream
]

{ #category : #evaluating }
VDMC >> init [
	lock
		critical: [ 
			| result postState |
			result := engine evaluate: String new specification: self specification states: Dictionary new.
			result third ifNotEmpty: [ :msg | ^ Error signal: msg ].
			postState := Dictionary new.
			result second
				keysAndValuesDo: [ :module :binds | 
					binds
						keysAndValuesDo: [ :var :value | 
							postState
								at:
									(var = 'DEFAULT'
										ifTrue: [ var ]
										ifFalse: [ module , '`' , var ])
								put: value ] ].
			state := postState]
]

{ #category : #'initialize-release' }
VDMC >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion.
	specification := String new.
	state := Dictionary new.
	reader := ViennaReader new.
	writer := ViennaWriter new
]

{ #category : #private }
VDMC >> parseJson: aJsonString [
	^ NeoJSONReader fromString: aJsonString
]

{ #category : #'accessing-plain' }
VDMC >> plainAt: aString [
	^ self
		plainAt: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]
]

{ #category : #'accessing-plain' }
VDMC >> plainAt: aString ifAbsent: errorBlock [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: errorBlock
]

{ #category : #'accessing-plain' }
VDMC >> plainAt: aString ifAbsentPut: errorBlock [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [ state at: aString put: errorBlock value ]
]

{ #category : #'accessing-plain' }
VDMC >> plainAt: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ state at: aString ifPresent: [ :value | aBlock cull: value ] ifAbsent: errorBlock
]

{ #category : #'accessing-plain' }
VDMC >> plainAt: aString put: anObject [
	^ state at: aString put: anObject
]

{ #category : #evaluating }
VDMC >> plainEvaluate: aString [
	^ self plainEvaluate: aString ifError: [ :msg | Error signal: msg ]
]

{ #category : #evaluating }
VDMC >> plainEvaluate: aString ifError: errorBlock [
	lock
		critical: [ 
			| preState result postState |
			preState := Dictionary new.
			state
				keysAndValuesDo: [ :key :value | 
					| module var |
					(key includes: $`)
						ifTrue: [ 
							| index |
							index := key indexOf: $`.
							module := key copyFrom: 1 to: index - 1.
							var := key copyFrom: index + 1 to: key size ]
						ifFalse: [ 
							module := 'DEFAULT'.
							var := key ].
					(preState at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ].
			result := engine evaluate: aString specification: self specification states: preState.
			result third ifNotEmpty: [ :msg | ^ errorBlock value: msg ].
			postState := Dictionary new.
			result second
				keysAndValuesDo: [ :module :binds | 
					binds
						keysAndValuesDo: [ :var :value | 
							postState
								at:
									(var = 'DEFAULT'
										ifTrue: [ var ]
										ifFalse: [ module , '`' , var ])
								put: value ] ].
			state := postState.
			^ result first ]
]

{ #category : #evaluating }
VDMC >> plainEvaluate: aString in: moduleName ifError: errorBlock [
	lock
		critical: [ 
			| preState result postState |
			preState := Dictionary new.
			state
				keysAndValuesDo: [ :key :value | 
					| module var |
					(key includes: $`)
						ifTrue: [ 
							| index |
							index := key indexOf: $`.
							module := key copyFrom: 1 to: index - 1.
							var := key copyFrom: index + 1 to: key size ]
						ifFalse: [ 
							module := 'DEFAULT'.
							var := key ].
					(preState at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ].
			result := engine evaluate: aString specification: self specification states: preState module: moduleName.
			result third ifNotEmpty: [ :msg | ^ errorBlock value: msg ].
			postState := Dictionary new.
			result second
				keysAndValuesDo: [ :module :binds | 
					binds
						keysAndValuesDo: [ :var :value | 
							postState
								at:
									(var = 'DEFAULT'
										ifTrue: [ var ]
										ifFalse: [ module , '`' , var ])
								put: value ] ].
			state := postState.
			^ result first ]
]

{ #category : #accessing }
VDMC >> reader [
	^ reader
]

{ #category : #accessing }
VDMC >> reader: aVDMCReader [
	reader := aVDMCReader
]

{ #category : #accessing }
VDMC >> specification [
	^ specification
]

{ #category : #accessing }
VDMC >> specification:aString [
	specification := aString
]

{ #category : #private }
VDMC >> state [
	^ state copy
]

{ #category : #private }
VDMC >> stringify: aJsonObject [
	^ String streamContents: [ :stream |
			(NeoJSONWriter on: stream) asciiOnly: true; nextPut: aJsonObject ]

]

{ #category : #accessing }
VDMC >> writer [
	^ writer
]

{ #category : #accessing }
VDMC >> writer: aVDMCWriter [
	writer := aVDMCWriter
]
