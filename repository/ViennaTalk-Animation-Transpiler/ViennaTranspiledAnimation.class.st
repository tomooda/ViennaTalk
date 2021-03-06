Class {
	#name : #ViennaTranspiledAnimation,
	#superclass : #Model,
	#instVars : [
		'specification',
		'object',
		'parser',
		'transpiler',
		'reader',
		'writer'
	],
	#category : #'ViennaTalk-Animation-Transpiler'
}

{ #category : #converting }
ViennaTranspiledAnimation >> asInterpretedAnimation [
	| animation |
	animation := ViennaAnimation default.
	animation specification: specification ifError: [ :msg | self error: msg ].
	self state
		keysAndValuesDo: [ :globalName :value | animation plainAt: globalName put: value ].
	^ animation
]

{ #category : #converting }
ViennaTranspiledAnimation >> asTranspiledAnimation [
	^ self
]

{ #category : #accessing }
ViennaTranspiledAnimation >> at: aString ifAbsent: aBlock [
	^ self at: aString ifPresent: [ :value | ] ifAbsent: aBlock
]

{ #category : #accessing }
ViennaTranspiledAnimation >> at: aString ifPresent: aBlock [
	^ self at: aString ifPresent: aBlock ifAbsent: [  ]
]

{ #category : #accessing }
ViennaTranspiledAnimation >> at: aString ifPresent: presentBlock ifAbsent: absentBlock [
	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [ target := object.
			name := aString ]
		ifFalse: [ | moduleName |
			moduleName := aString copyFrom: 1 to: separatorIndex - 1.
			target := moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: moduleName ifAbsent: [ ^ absentBlock value ] ].
			name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name ]
		on: Error
		do: [ :ex | ^ absentBlock value ].
	^ presentBlock value: value
]

{ #category : #accessing }
ViennaTranspiledAnimation >> at: aString put: anObject [
	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [ target := object.
			name := aString ]
		ifFalse: [ | moduleName |
			moduleName := aString copyFrom: 1 to: separatorIndex - 1.
			target := moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: (aString copyFrom: 1 to: separatorIndex - 1) ifAbsent: [ ^ nil ] ].
			name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name put: anObject ]
		on: Error
		do: [ :ex | ^ nil ].
	^ value
]

{ #category : #private }
ViennaTranspiledAnimation >> becomeInterpretedAnimation [
	| animation |
	animation := self asInterpretedAnimation.
	self dependents do: [ :dependent |  animation addDependent: dependent].
	self become: animation
]

{ #category : #private }
ViennaTranspiledAnimation >> becomeTranspiledAnimation [
	^ self
]

{ #category : #converting }
ViennaTranspiledAnimation >> copyForTest [
	^ self copy
]

{ #category : #private }
ViennaTranspiledAnimation >> defaultModule [
	^ 'DEFAULT'
]

{ #category : #accessing }
ViennaTranspiledAnimation >> engineType [
	^ #transpiler
]

{ #category : #evaluating }
ViennaTranspiledAnimation >> evaluate: aString in: moduleName ifError: errorBlock [
	Cursor wait
		showWhile: [ | result |
			result := (moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: moduleName ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
				evaluateExpression: aString
				with: transpiler
				ifError: [ :msg | ^ errorBlock cull: msg ].
			self changed: #state.
			^ result == object
				ifTrue: [ nil ]
				ifFalse: [ result ] ]
]

{ #category : #evaluating }
ViennaTranspiledAnimation >> init [
	object init
]

{ #category : #'initialize-release' }
ViennaTranspiledAnimation >> initialize [
	super initialize.
	parser := ViennaVDMParser new.
	reader := ViennaReader new.
	writer := ViennaUnquoteWriter new
]

{ #category : #accessing }
ViennaTranspiledAnimation >> plainAt: aString [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [  ]
]

{ #category : #accessing }
ViennaTranspiledAnimation >> plainAt: aString ifAbsent: absentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | value ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
ViennaTranspiledAnimation >> plainAt: aString ifPresent: presentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | presentBlock value: value viennaString ]
		ifAbsent: [  ]
]

{ #category : #accessing }
ViennaTranspiledAnimation >> plainAt: aString ifPresent: presentBlock ifAbsent: absentBlock [
	^ self
		at: aString
		ifPresent: [ :value | presentBlock value: (writer stringify: value) ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
ViennaTranspiledAnimation >> plainAt: aString put: aVDMString [
	^ self at: aString put: (reader parse: aVDMString)
]

{ #category : #evaluating }
ViennaTranspiledAnimation >> plainEvaluate: aString [
	^ self plainEvaluate: aString ifError: [ :msg | self error: msg ]
]

{ #category : #evaluating }
ViennaTranspiledAnimation >> plainEvaluate: aString ifError: errorBlock [
	^ self plainEvaluate: aString in: self defaultModule ifError: errorBlock
]

{ #category : #evaluating }
ViennaTranspiledAnimation >> plainEvaluate: aString in: moduleName ifError: errorBlock [
	| result |
	result := writer
		stringify: (self evaluate: aString in: moduleName ifError: [ :msg | ^ errorBlock value: msg ]).
	^ result
]

{ #category : #copying }
ViennaTranspiledAnimation >> postCopy [
	| oldState oldSpec |
	oldState := self state.
	oldSpec := self specification.
	super postCopy.
	object := object copy.
	self state: oldState
]

{ #category : #accessing }
ViennaTranspiledAnimation >> specification [
	^ specification ifNil: [ '' ]
]

{ #category : #accessing }
ViennaTranspiledAnimation >> specification: aString [
	self specification: aString ifError: [ :msg | ]
]

{ #category : #accessing }
ViennaTranspiledAnimation >> specification: aString ifError: errorBlock [
	transpiler := ViennaVDM2SmalltalkObject new.
	aString
		ifEmpty: [ object := ViennaTranspiledObject new ]
		ifNotEmpty: [ | ast |
			ast := parser parse: aString.
			ast isPetit2Failure
				ifTrue: [ ^ errorBlock value: ast message ].
			object := transpiler generate: ast ].
	specification := aString.
	self changed: #specification.
	self changed: #state
]

{ #category : #private }
ViennaTranspiledAnimation >> state [
	| state |
	state := Dictionary new.
	object
		ifNotNil: [ object isDictionary
				ifTrue: [ object
						keysAndValuesDo: [ :moduleName :module | 
							| moduleState |
							moduleState := module state.
							moduleState namedFields
								keysAndValuesDo:
									[ :varName :varIndex | state at: moduleName , '`' , varName put: (writer stringify: (moduleState at: varIndex)) ] ] ]
				ifFalse: [ | moduleState |
					moduleState := object state.
					moduleState namedFields
						keysAndValuesDo:
							[ :varName :varIndex | state at: self defaultModule, '`', varName put: (writer stringify: (moduleState at: varIndex)) ] ] ].
	^ state
]

{ #category : #private }
ViennaTranspiledAnimation >> state: aDictionary [
	object
		viennaAtomic: [ aDictionary keysAndValuesDo: [ :var :val | [self at: var put: (reader parse: val)] on: Error do: [ :ex | ex resume ] ] ]
]
