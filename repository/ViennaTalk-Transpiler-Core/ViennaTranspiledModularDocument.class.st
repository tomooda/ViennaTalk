Class {
	#name : #ViennaTranspiledModularDocument,
	#superclass : #Dictionary,
	#instVars : [
		'viennaEnv'
	],
	#category : #'ViennaTalk-Transpiler-Core'
}

{ #category : #'instance creation' }
ViennaTranspiledModularDocument class >> from: aDictionary [
	| doc |
	doc := self new.
	aDictionary keysAndValuesDo: [ :key :value | doc at: key put: value ].
	^ doc
]

{ #category : #private }
ViennaTranspiledModularDocument >> buildViennaEnv [
	| env |
	env := Dictionary new.
	self keysDo: [ :key | env at: key put: '(self at: ' , key storeString , ')' ].
	viennaEnv := env
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateExpression: aString [
	^ self evaluateExpression: aString ifError: [ :msg | self error: msg ]
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateExpression: aString ifError: errorBlock [
	^ self evaluateExpression: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateExpression: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [
	| src |
	src := self
		transpileExpression: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ OpalCompiler new
		source: src;
		logged: false;
		receiver: self;
		evaluate
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateStatement: aString [
	^ self evaluateStatement: aString ifError: [ :msg | self error: msg ]
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateStatement: aString ifError: errorBlock [
	^ self evaluateStatement: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : #evaluating }
ViennaTranspiledModularDocument >> evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [
	| src |
	src := self class
		transpileStatement: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ OpalCompiler new
		source: src;
		receiver: self;
		evaluate
]

{ #category : #initialize }
ViennaTranspiledModularDocument >> initialize [
	super initialize.
	viennaEnv := Dictionary new
]

{ #category : #private }
ViennaTranspiledModularDocument >> inv [
]

{ #category : #copying }
ViennaTranspiledModularDocument >> postCopy [
	super postCopy.
	self keys do: [ :key | self at: key put: (self at: key) copy ].
	self
		valuesDo: [ :module | 
			self
				keysDo: [ :key | 
					(module respondsTo: (key , ':') asSymbol)
						ifTrue: [ module perform: (key , ':') asSymbol with: (self at: key) ] ] ]
]

{ #category : #transpiling }
ViennaTranspiledModularDocument >> transpileExpression: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : #transpiling }
ViennaTranspiledModularDocument >> transpileStatement: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : #accessing }
ViennaTranspiledModularDocument >> viennaEnv [
	^ viennaEnv
]

{ #category : #accessing }
ViennaTranspiledModularDocument >> viennaEnv: aDictionary [
	viennaEnv := aDictionary
]
