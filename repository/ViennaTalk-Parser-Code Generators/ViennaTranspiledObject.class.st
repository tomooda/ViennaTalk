Class {
	#name : #ViennaTranspiledObject,
	#superclass : #Object,
	#classInstVars : [
		'viennaEnv',
		'specification',
		'nodeDict'
	],
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #'class initialization' }
ViennaTranspiledObject class >> initialize [
	super initialize.
	nodeDict := Dictionary new
]

{ #category : #specification }
ViennaTranspiledObject class >> nodeAt: aSelector put: aViennaNode [
	^ self nodeDict at: aSelector asSymbol put: aViennaNode
]

{ #category : #specification }
ViennaTranspiledObject class >> nodeDict [
	^ nodeDict ifNil: [ nodeDict := Dictionary new ]
]

{ #category : #specification }
ViennaTranspiledObject class >> specSourceAt: aSelector [
	^ self specSourceFor: (self nodeDict at: aSelector asSymbol ifAbsent: [ ^ String new ])
]

{ #category : #specification }
ViennaTranspiledObject class >> specSourceFor: aViennaNode [
	^ specification
		ifNil: [ ViennaVDMFormatter new format: aViennaNode ]
		ifNotNil: [ | start end |
			start := aViennaNode start.
			end := aViennaNode end.
			(start isNil or: [ end isNil ])
				ifTrue: [ ViennaVDMFormatter new format: aViennaNode ]
				ifFalse: [ specification copyFrom: start to: end ] ]
]

{ #category : #specification }
ViennaTranspiledObject class >> specification [
	^ specification
]

{ #category : #specification }
ViennaTranspiledObject class >> specification: aStringOrText [
	specification := aStringOrText
]

{ #category : #transpiling }
ViennaTranspiledObject class >> transpileExpression: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : #transpiling }
ViennaTranspiledObject class >> transpileStatement: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : #accessing }
ViennaTranspiledObject class >> viennaEnv [
	^ viennaEnv
]

{ #category : #accessing }
ViennaTranspiledObject class >> viennaEnv: aDictionary [
	viennaEnv := aDictionary
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateExpression: aString [
	^ self evaluateExpression: aString ifError: [ :msg | self error: msg ]
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateExpression: aString ifError: errorBlock [
	^ self evaluateExpression: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateExpression: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [
	| src |
	src := self class
		transpileExpression: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ Compiler evaluate: src for: self logged: false
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateStatement: aString [
	^ self evaluateStatement: aString ifError: [ :msg | self error: msg ]
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateStatement: aString ifError: errorBlock [
	^ self evaluateStatement: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : #evaluating }
ViennaTranspiledObject >> evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [
	| src |
	src := self class
		transpileStatement: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ Compiler evaluate: src for: self logged: false
]

{ #category : #private }
ViennaTranspiledObject >> state [
	^ (ViennaComposite constructorName: '')
]
