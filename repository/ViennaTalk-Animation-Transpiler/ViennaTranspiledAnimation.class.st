Class {
	#name : 'ViennaTranspiledAnimation',
	#superclass : 'Model',
	#instVars : [
		'specification',
		'object',
		'parser',
		'transpiler',
		'reader',
		'writer'
	],
	#classVars : [
		'UseTranspilerByDefault'
	],
	#category : 'ViennaTalk-Animation-Transpiler',
	#package : 'ViennaTalk-Animation-Transpiler'
}

{ #category : 'accessing' }
ViennaTranspiledAnimation class >> useTranspilerByDefault [

	^ UseTranspilerByDefault ~= false
]

{ #category : 'accessing' }
ViennaTranspiledAnimation class >> useTranspilerByDefault: aBoolean [

	UseTranspilerByDefault := aBoolean = true
]

{ #category : 'settings' }
ViennaTranspiledAnimation class >> viennaSettingsOn: aBuilder [

	<systemsettings>
	(aBuilder setting: #ViennaTalkUseTranspilerByDefault)
		parent: #ViennaTalkCodeGenerator;
		target: self;
		getSelector: #useTranspilerByDefault;
		setSelector: #useTranspilerByDefault:;
		description: 'If checked, animation will use transpiler by default';
		label: 'Use transpiler by default';
		order: 0.4
]

{ #category : 'announcement' }
ViennaTranspiledAnimation >> announceSpecificationChanged [

	self announcer announce: (ViennaSpecificationChanged new
			 animation: self;
			 yourself)
]

{ #category : 'announcement' }
ViennaTranspiledAnimation >> announceStateChanged [

	self announcer announce: (ViennaStateChanged new
			 animation: self;
			 yourself)
]

{ #category : 'converting' }
ViennaTranspiledAnimation >> asInterpretedAnimation [
	| animation |
	animation := ViennaAnimation default.
	animation specification: specification ifError: [ :msg | self error: msg ].
	self state
		keysAndValuesDo: [ :globalName :value | animation plainAt: globalName put: value ].
	^ animation
]

{ #category : 'converting' }
ViennaTranspiledAnimation >> asTranspiledAnimation [
	^ self
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> at: aString [

	^ self at: aString ifPresent: #yourself ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> at: aString ifAbsent: aBlock [

	^ self at: aString ifPresent: #yourself ifAbsent: aBlock
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> at: aString ifPresent: aBlock [
	^ self at: aString ifPresent: aBlock ifAbsent: [  ]
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
ViennaTranspiledAnimation >> at: aString put: anObject [

	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [
			target := object.
			name := aString ]
		ifFalse: [
			| moduleName |
			moduleName := aString copyFrom: 1 to: separatorIndex - 1.
			target := moduleName = self defaultModule
				          ifTrue: [ object ]
				          ifFalse: [
					          object
						          at: (aString copyFrom: 1 to: separatorIndex - 1)
						          ifAbsent: [ ^ nil ] ].
			name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name put: anObject ]
		on: Error
		do: [ :ex | ^ nil ].
	self announceStateChanged.
	^ value
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> basicAt: aString put: anObject [

	| separatorIndex target name |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [
				target := object.
				name := aString ]
		ifFalse: [
				| moduleName |
				moduleName := aString copyFrom: 1 to: separatorIndex - 1.
				target := moduleName = self defaultModule
					          ifTrue: [ object ]
					          ifFalse: [
							          object
								          at: (aString copyFrom: 1 to: separatorIndex - 1)
								          ifAbsent: [ ^ nil ] ].
				name := aString copyFrom: separatorIndex + 1 to: aString size ].
	target basicInstVarNamed: name put: anObject.
	^ anObject
]

{ #category : 'private' }
ViennaTranspiledAnimation >> becomeInterpretedAnimation [
	| animation |
	animation := self asInterpretedAnimation.
	self dependents do: [ :dependent |  animation addDependent: dependent].
	self become: animation
]

{ #category : 'private' }
ViennaTranspiledAnimation >> becomeTranspiledAnimation [
	^ self
]

{ #category : 'converting' }
ViennaTranspiledAnimation >> copyForTest [
	^ self copy
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> debug: aString in: moduleName ifError: errorBlock [

	Cursor wait showWhile: [
		| result |
		result := (moduleName = self defaultModule
			           ifTrue: [ object ]
			           ifFalse: [
				           object
					           at: moduleName
					           ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
			          debugExpression: aString
			          with: transpiler
			          ifError: [ :msg | ^ errorBlock cull: msg ].
		self changed: #state.
		self announceStateChanged.
		^ result == object
			  ifTrue: [ nil ]
			  ifFalse: [ result ] ]
]

{ #category : 'private' }
ViennaTranspiledAnimation >> defaultModule [
	^ 'DEFAULT'
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> engineType [
	^ #transpiler
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> evaluate: aString [

	^ self
		  evaluate: aString
		  in: self defaultModule
		  ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> evaluate: aString in: moduleName ifError: errorBlock [

	Cursor wait showWhile: [
		| result |
		result := (moduleName = self defaultModule
			           ifTrue: [ object ]
			           ifFalse: [
				           object
					           at: moduleName
					           ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
			          evaluateExpression: aString
			          with: transpiler
			          ifError: [ :msg | ^ errorBlock cull: msg ].
		self changed: #state.
		self announceStateChanged.
		^ result == object
			  ifTrue: [ nil ]
			  ifFalse: [ result ] ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> execute: aViennaNode in: moduleName ifError: errorBlock [

	Cursor wait showWhile: [
		| result |
		result := (moduleName = self defaultModule
			           ifTrue: [ object ]
			           ifFalse: [
				           object
					           at: moduleName
					           ifAbsent: [ ^ errorBlock cull: 'unknown module name' ] ])
			          evaluateNode: aViennaNode
			          with: transpiler
			          ifError: [ :msg | ^ errorBlock cull: msg ].
		self changed: #state.
		self announceStateChanged.
		^ result ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> init [
	object init
]

{ #category : 'initialize-release' }
ViennaTranspiledAnimation >> initialize [

	super initialize.
	parser := ViennaVDMParser current.
	reader := ViennaReader new.
	writer := ViennaUnquoteWriter new.
	self specification: String new ifError: [  ]
]

{ #category : 'testing' }
ViennaTranspiledAnimation >> isTranspiledAnimation [

	^ true
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> plainAt: aString [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> plainAt: aString ifAbsent: absentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | value ]
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> plainAt: aString ifPresent: presentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | presentBlock value: value viennaString ]
		ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> plainAt: aString ifPresent: presentBlock ifAbsent: absentBlock [
	^ self
		at: aString
		ifPresent: [ :value | presentBlock value: (writer stringify: value) ]
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> plainAt: aString put: aVDMString [

	^ self at: aString put: (reader parse: aVDMString)
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainEvaluate: aString [
	^ self plainEvaluate: aString ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainEvaluate: aString ifError: errorBlock [
	^ self plainEvaluate: aString in: self defaultModule ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainEvaluate: aString in: moduleName ifError: errorBlock [

	^ writer stringify: (self
			   evaluate: aString
			   in: (moduleName ifNil: [ self defaultModule ])
			   ifError: [ :msg | ^ errorBlock value: msg ])
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainExecute: aViennaNode [

	^ self plainExecute: aViennaNode ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainExecute: aViennaNode ifError: errorBlock [

	^ self
		  plainExecute: aViennaNode
		  in: self defaultModule
		  ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> plainExecute: aViennaNode in: moduleName ifError: errorBlock [

	^ writer stringify: (self
			   execute: aViennaNode
			   in: (moduleName ifNil: [ self defaultModule ])
			   ifError: [ :msg | ^ errorBlock value: msg ])
]

{ #category : 'copying' }
ViennaTranspiledAnimation >> postCopy [
	| oldState oldSpec |
	oldState := self state.
	oldSpec := self specification.
	super postCopy.
	object := object copy.
	self state: oldState
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> runTestOperation: aString module: anotherString [

	| moduleObject operationNode acts fins rds wrs |
	moduleObject := object at: anotherString.
	operationNode := moduleObject class specificationAt: aString asSymbol.
	acts := Set new.
	fins := Set new.
	rds := Set new.
	wrs := Set new.
	operationNode
		allDescendantsSuchThat: #isViennaHistoryExpressionNode
		do: [ :node |
			node isViennaActExpressionNode ifTrue: [
				node nameList do: [ :name |
					name asGlobalName ifNotNil: [ :globalName |
						acts add: {
								{
									globalName moduleIdentifier asSymbol.
									globalName identifier asSymbol }.
								(object at: globalName moduleIdentifier).
								(globalName identifier , ':') asSymbol } ] ] ].
			node isViennaFinExpressionNode ifTrue: [
				node nameList do: [ :name |
					name asGlobalName ifNotNil: [ :globalName |
						fins add: {
								{
									globalName moduleIdentifier asSymbol.
									globalName identifier asSymbol }.
								(object at: globalName moduleIdentifier).
								(globalName identifier , ':') asSymbol } ] ] ].
			node isViennaRdExpressionNode ifTrue: [
				node nameList do: [ :name |
					name asGlobalName ifNotNil: [ :globalName |
						rds add: {
								{
									globalName moduleIdentifier asSymbol.
									globalName identifier asSymbol }.
								(object at: globalName moduleIdentifier).
								globalName identifier asSymbol } ] ] ].
			node isViennaWrExpressionNode ifTrue: [
				node nameList do: [ :name |
					name asGlobalName ifNotNil: [ :globalName |
						wrs add: {
								{
									globalName moduleIdentifier asSymbol.
									globalName identifier asSymbol }.
								(object at: globalName moduleIdentifier).
								globalName identifier asSymbol } ] ] ] ].
	self init.
	ViennaProfiler
		act: acts asArray
		fin: fins asArray
		rd: rds asArray
		wr: wrs asArray
		do: [
			[ (moduleObject perform: aString asSymbol) value ]
				on: ViennaAssertionViolation
				do: [ :ex |
				ex resignalAs: (ViennaException expression: ex expression) ] ]
]

{ #category : 'evaluating' }
ViennaTranspiledAnimation >> runTrace: aString module: anotherString do: aBlock onError: errorBlock [

	(object at: anotherString)
		perform: (aString , ':onError:') asSymbol
		with: aBlock
		with: errorBlock
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> specification [
	^ specification ifNil: [ '' ]
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> specification: aString [
	self specification: aString ifError: [ :msg | ]
]

{ #category : 'accessing' }
ViennaTranspiledAnimation >> specification: aString ifError: errorBlock [

	| ast |
	transpiler := ViennaVDM2SmalltalkObject new.
	ast := aString isViennaNode
		       ifTrue: [ aString ]
		       ifFalse: [
			       aString
				       ifNotEmpty: [
					       | result |
					       result := parser parse: aString.
					       result isPetit2Failure ifTrue: [
						       ^ errorBlock cull: result message ].
					       result ]
				       ifEmpty: [ ViennaModularDocumentNode empty ] ].
	[ ast typecheck ]
		on: ViennaTypeError
		do: [ :typeError | ^ errorBlock cull: typeError messageText ].
	object := transpiler generate: ast.
	specification := aString.
	self changed: #specification.
	self announceSpecificationChanged.
	self changed: #state.
	self announceStateChanged
]

{ #category : 'private' }
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

{ #category : 'private' }
ViennaTranspiledAnimation >> state: aDictionary [

	aDictionary keysAndValuesDo: [ :var :val |
		self basicAt: var put: (reader parse: val) ].
	object inv.
	self announceStateChanged
]
