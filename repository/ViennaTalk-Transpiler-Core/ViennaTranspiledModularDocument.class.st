Class {
	#name : 'ViennaTranspiledModularDocument',
	#superclass : 'Dictionary',
	#instVars : [
		'viennaEnv'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaTranspiledModularDocument class >> from: aDictionary [

	| doc |
	doc := self new.
	aDictionary keysAndValuesDo: [ :key :value |
		doc at: key put: value.
		value _document: doc ].
	^ doc
]

{ #category : 'private' }
ViennaTranspiledModularDocument >> buildViennaEnv [
	| env |
	env := Dictionary new.
	self keysDo: [ :key | env at: key put: '(self at: ' , key storeString , ')' ].
	viennaEnv := env
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> debugExpression: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| src |
	src := 'self halt. ' , (self
		        transpileExpression: aString
		        with: aViennaVDM2SmalltalkClass
		        ifError: [ :msg | ^ errorBlock cull: msg ]).
	^ OpalCompiler new
		  source: src;
		  logged: false;
		  receiver: self;
		  evaluate
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateExpression: aString [
	^ self evaluateExpression: aString ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateExpression: aString ifError: errorBlock [
	^ self evaluateExpression: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : 'evaluating' }
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

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateNode: aViennaNode [

	^ self evaluateNode: aViennaNode ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateNode: aViennaNode ifError: errorBlock [

	^ self
		  evaluateNode: aViennaNode
		  with: ViennaVDM2SmalltalkClass new
		  ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateNode: aViennaNode with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| src |
	src := self
		       transpileNode: aViennaNode
		       with: aViennaVDM2SmalltalkClass
		       ifError: [ :msg | ^ errorBlock cull: msg ].
	^ OpalCompiler new
		  source: src;
		  logged: false;
		  receiver: self;
		  evaluate
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateStatement: aString [
	^ self evaluateStatement: aString ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateStatement: aString ifError: errorBlock [
	^ self evaluateStatement: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocument >> evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [
	| src |
	src := self
		transpileStatement: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ OpalCompiler new
		source: src;
		logged: false;
		receiver: self;
		evaluate
]

{ #category : 'private' }
ViennaTranspiledModularDocument >> init [

	self valuesDo: #init
]

{ #category : 'initialize' }
ViennaTranspiledModularDocument >> initialize [
	super initialize.
	viennaEnv := Dictionary new
]

{ #category : 'private' }
ViennaTranspiledModularDocument >> inv [
]

{ #category : 'copying' }
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

{ #category : 'accessing' }
ViennaTranspiledModularDocument >> state [

	^ self collect: [ :module | module state ]
]

{ #category : 'accessing' }
ViennaTranspiledModularDocument >> state: aDictionary [

	aDictionary keysAndValuesDo: [ :moduleName :state |
		self at: moduleName ifPresent: [ :module | module state: state ] ]
]

{ #category : 'transpiling' }
ViennaTranspiledModularDocument >> transpileExpression: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser current expression end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : 'transpiling' }
ViennaTranspiledModularDocument >> transpileNode: aViennaNode with: transpiler ifError: errorBlock [

	^ transpiler
		  defaultEnv: viennaEnv;
		  generate: aViennaNode
]

{ #category : 'transpiling' }
ViennaTranspiledModularDocument >> transpileStatement: aString with: transpiler ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser current statement end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast
]

{ #category : 'accessing' }
ViennaTranspiledModularDocument >> viennaEnv [
	^ viennaEnv
]

{ #category : 'accessing' }
ViennaTranspiledModularDocument >> viennaEnv: aDictionary [
	viennaEnv := aDictionary
]
