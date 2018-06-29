Class {
	#name : #ViennaTranspiledObject,
	#superclass : #Object,
	#classInstVars : [
		'specificationDict',
		'debuggerNodeMapDict',
		'specification',
		'viennaEnv'
	],
	#category : 'ViennaTalk-Transpiler-Runtime'
}

{ #category : #specification }
ViennaTranspiledObject class >> debuggerNodeMapAt: aSymbol [
	^ self debuggerNodeMapDict at: aSymbol asSymbol
]

{ #category : #specification }
ViennaTranspiledObject class >> debuggerNodeMapAt: aSymbol put: anIdentityDictionary [
	^ self debuggerNodeMapDict at: aSymbol asSymbol put: anIdentityDictionary
]

{ #category : #specification }
ViennaTranspiledObject class >> debuggerNodeMapDict [
	^ debuggerNodeMapDict ifNil: [ debuggerNodeMapDict := Dictionary new ]
]

{ #category : #specification }
ViennaTranspiledObject class >> includesSpecificationFor: aSymbol [
	^ self specificationDict includesKey: aSymbol asSymbol
]

{ #category : #'class initialization' }
ViennaTranspiledObject class >> initialize [
	specificationDict := Dictionary new.
]

{ #category : #specification }
ViennaTranspiledObject class >> specification [
	^ specification
]

{ #category : #specification }
ViennaTranspiledObject class >> specification: aViennaNode [
	specification := aViennaNode
]

{ #category : #specification }
ViennaTranspiledObject class >> specificationAt: aSymbol [
	^ self specificationDict at: aSymbol asSymbol
]

{ #category : #specification }
ViennaTranspiledObject class >> specificationAt: aSelector put: aViennaNode [
	^ self specificationDict at: aSelector asSymbol put: aViennaNode
]

{ #category : #specification }
ViennaTranspiledObject class >> specificationDict [
	^ specificationDict ifNil: [ specificationDict := Dictionary new ]
]

{ #category : #specification }
ViennaTranspiledObject class >> specificationSource [
	^ specification ifNotNil: #source ifNil: [  ]
]

{ #category : #specification }
ViennaTranspiledObject class >> specificationSourceAt: aSelector [
	^ (self specificationAt: aSelector) source
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