Class {
	#name : 'ViennaAnimation',
	#superclass : 'Model',
	#instVars : [
		'specification',
		'object',
		'parser',
		'transpiler',
		'reader',
		'writer',
		'specificationNode'
	],
	#classVars : [
		'UseTranspilerByDefault'
	],
	#category : 'ViennaTalk-Animation-Core',
	#package : 'ViennaTalk-Animation-Core'
}

{ #category : 'announcement' }
ViennaAnimation >> announceEvaluated [

	self announcer announce: (ViennaAnimationEvaluated new
			 animation: self;
			 yourself)
]

{ #category : 'announcement' }
ViennaAnimation >> announceSpecificationChanged [

	self announcer announce: (ViennaAnimationSpecificationChanged new
			 animation: self;
			 yourself)
]

{ #category : 'announcement' }
ViennaAnimation >> announceStateChanged [

	self announcer announce: (ViennaAnimationStateChanged new
			 animation: self;
			 yourself)
]

{ #category : 'accessing' }
ViennaAnimation >> at: aString [

	^ self at: aString ifPresent: #yourself ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaAnimation >> at: aString ifAbsent: aBlock [

	^ self at: aString ifPresent: #yourself ifAbsent: aBlock
]

{ #category : 'accessing' }
ViennaAnimation >> at: aString ifPresent: aBlock [
	^ self at: aString ifPresent: aBlock ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaAnimation >> at: aString ifPresent: presentBlock ifAbsent: absentBlock [

	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [
				target := object.
				name := aString ]
		ifFalse: [
				| moduleName |
				moduleName := aString copyFrom: 1 to: separatorIndex - 1.
				target := object at: moduleName ifAbsent: [ ^ absentBlock value ].
				name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name ]
		on: Error
		do: [ :ex | ^ absentBlock value ].
	^ presentBlock value: value
]

{ #category : 'accessing' }
ViennaAnimation >> at: aString put: anObject [

	| separatorIndex target name oldValue value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [
				target := object.
				name := aString ]
		ifFalse: [
				| moduleName |
				moduleName := aString copyFrom: 1 to: separatorIndex - 1.
				target := object at: (aString copyFrom: 1 to: separatorIndex - 1) ifAbsent: [ ^ nil ].
				name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[
		oldValue := target instVarNamed: name.
		value := target instVarNamed: name put: anObject ]
		on: Error
		do: [ :ex | ^ nil ].
	oldValue ~= value ifTrue: [ self announceStateChanged ].
	^ value
]

{ #category : 'accessing' }
ViennaAnimation >> basicAt: aString put: anObject [

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
ViennaAnimation >> becomeTranspiledAnimation [
	^ self
]

{ #category : 'converting' }
ViennaAnimation >> copyForTest [
	^ self copy
]

{ #category : 'evaluating' }
ViennaAnimation >> debug: aString in: moduleName ifError: errorBlock [

	| oldState |
	oldState := self state.
	Cursor wait showWhile: [
			| result |
			result := (moduleName = self defaultModule
				           ifTrue: [ object ]
				           ifFalse: [ object at: moduleName ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
				          debugExpression: aString
				          with: transpiler
				          ifError: [ :msg | ^ errorBlock cull: msg ].
			oldState ~= self state ifTrue: [
					self changed: #state.
					self announceStateChanged ].
			self announceEvaluated.
			^ result == object
				  ifTrue: [ nil ]
				  ifFalse: [ result ] ]
]

{ #category : 'private' }
ViennaAnimation >> defaultModule [
	^ 'DEFAULT'
]

{ #category : 'accessing' }
ViennaAnimation >> engineType [
	^ #transpiler
]

{ #category : 'evaluating' }
ViennaAnimation >> evaluate: aString [

	^ self
		  evaluate: aString
		  in: self defaultModule
		  ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaAnimation >> evaluate: aString in: moduleName do: aBlock ifError: errorBlock [

	Cursor wait showWhile: [
			| oldState result state |
			oldState := self state.
			result := (object at: moduleName ifAbsent: [ object ])
				          evaluateExpression: aString
				          with: transpiler
				          ifError: [ :msg | ^ errorBlock cull: msg ].
			state := self state.
			[ aBlock ifNotNil: [ result := aBlock cull: result cull: state ] ] ensure: [
					oldState ~= state ifTrue: [
							self changed: #state.
							self announceStateChanged ] ].
			self announceEvaluated.
			^ result ]
]

{ #category : 'evaluating' }
ViennaAnimation >> evaluate: aString in: moduleName ifError: errorBlock [

	^ self
		  evaluate: aString
		  in: moduleName
		  do: nil
		  ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaAnimation >> execute: aViennaNode in: moduleName do: aBlock ifError: errorBlock [

	Cursor wait showWhile: [
			| oldState result state |
			oldState := self state.
			result := ((moduleName isNil or: [ moduleName = self defaultModule ])
				           ifTrue: [ object ]
				           ifFalse: [ object at: moduleName ifAbsent: [ ^ errorBlock cull: 'unknown module name' ] ])
				          evaluateNode: aViennaNode
				          with: transpiler
				          ifError: [ :msg | ^ errorBlock cull: msg ].
			state := self state.
			[ aBlock ifNotNil: [ result := aBlock cull: result cull: state ] ] ensure: [
					oldState ~= state ifTrue: [
							self changed: #state.
							self announceStateChanged ] ].
			self announceEvaluated.
			^ result ]
]

{ #category : 'evaluating' }
ViennaAnimation >> execute: aViennaNode in: moduleName ifError: errorBlock [

	^ self
		  execute: aViennaNode
		  in: moduleName
		  do: nil
		  ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaAnimation >> init [
	object init
]

{ #category : 'initialize-release' }
ViennaAnimation >> initialize [

	super initialize.
	parser := ViennaVDMParser current.
	reader := ViennaReader new.
	writer := ViennaUnquoteWriter new.
	self specification: String new ifError: [  ]
]

{ #category : 'testing' }
ViennaAnimation >> isTranspiledAnimation [

	^ true
]

{ #category : 'accessing' }
ViennaAnimation >> plainAt: aString [
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaAnimation >> plainAt: aString ifAbsent: absentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | value ]
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
ViennaAnimation >> plainAt: aString ifPresent: presentBlock [
	^ self
		plainAt: aString
		ifPresent: [ :value | presentBlock value: value viennaString ]
		ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaAnimation >> plainAt: aString ifPresent: presentBlock ifAbsent: absentBlock [
	^ self
		at: aString
		ifPresent: [ :value | presentBlock value: (writer stringify: value) ]
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
ViennaAnimation >> plainAt: aString put: aVDMString [

	^ self at: aString put: (reader parse: aVDMString)
]

{ #category : 'evaluating' }
ViennaAnimation >> plainEvaluate: aString [
	^ self plainEvaluate: aString ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaAnimation >> plainEvaluate: aString ifError: errorBlock [
	^ self plainEvaluate: aString in: self defaultModule ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaAnimation >> plainEvaluate: aString in: moduleName ifError: errorBlock [

	^ (self
			   evaluate: aString
			   in: (moduleName ifNil: [ self defaultModule ])
			   ifError: [ :msg | ^ errorBlock value: msg ]) viennaString
]

{ #category : 'evaluating' }
ViennaAnimation >> plainExecute: aViennaNode [

	^ self plainExecute: aViennaNode ifError: [ :msg | self error: msg ]
]

{ #category : 'evaluating' }
ViennaAnimation >> plainExecute: aViennaNode ifError: errorBlock [

	^ self
		  plainExecute: aViennaNode
		  in: self defaultModule
		  ifError: errorBlock
]

{ #category : 'evaluating' }
ViennaAnimation >> plainExecute: aViennaNode in: moduleName ifError: errorBlock [

	^ writer stringify: (self
			   execute: aViennaNode
			   in: (moduleName ifNil: [ self defaultModule ])
			   ifError: [ :msg | ^ errorBlock value: msg ])
]

{ #category : 'copying' }
ViennaAnimation >> postCopy [
	| oldState oldSpec |
	oldState := self state.
	oldSpec := self specification.
	super postCopy.
	object := object copy.
	self state: oldState
]

{ #category : 'evaluating' }
ViennaAnimation >> resolve: aViennaNameNode in: moduleName ifError: errorBlock [

	Cursor wait showWhile: [
			| scope |
			scope := (moduleName isNil or: [ moduleName = self defaultModule ])
				         ifTrue: [ specificationNode ]
				         ifFalse: [
				         (specificationNode moduleNamed: moduleName) ifNil: [ ^ errorBlock cull: 'unknown module name ' , moduleName ] ].
			^ aViennaNameNode
				  ifNotNil: [
						  aViennaNameNode parent: scope.
						  aViennaNameNode resolve ifNil: [ errorBlock cull: 'unknown name ' , aViennaNameNode source ] ]
				  ifNil: [ scope ] ]
]

{ #category : 'evaluating' }
ViennaAnimation >> runTestOperation: aString module: anotherString [

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
ViennaAnimation >> runTrace: aString module: anotherString do: aBlock onError: errorBlock [

	(object at: anotherString)
		perform: (aString , ':onError:') asSymbol
		with: aBlock
		with: errorBlock
]

{ #category : 'accessing' }
ViennaAnimation >> specification [
	^ specification ifNil: [ '' ]
]

{ #category : 'accessing' }
ViennaAnimation >> specification: aString [
	self specification: aString ifError: [ :msg | ]
]

{ #category : 'accessing' }
ViennaAnimation >> specification: aString ifError: errorBlock [

	self
		specificationNode: (aString isViennaNode
				 ifTrue: [ aString ]
				 ifFalse: [
						 aString
							 ifNotEmpty: [
									 | result |
									 result := parser parse: aString.
									 result isPetit2Failure ifTrue: [ ^ errorBlock cull: result message ].
									 result asModularDocument ]
							 ifEmpty: [ ViennaModularDocumentNode default ] ])
		ifError: errorBlock
]

{ #category : 'accessing' }
ViennaAnimation >> specificationNode [

	^ specificationNode
]

{ #category : 'accessing' }
ViennaAnimation >> specificationNode: aViennaModularDocumentNode ifError: errorBlock [

	| oldSpecificationNode oldState |
	oldSpecificationNode := specificationNode.
	oldState := self state.
	transpiler := self transpilerClass new.
	specificationNode := aViennaModularDocumentNode.
	[ specificationNode typecheck ]
		on: ViennaTypeError
		do: [ :typeError | ^ errorBlock cull: typeError messageText ].
	object := transpiler generate: specificationNode.
	specification := aViennaModularDocumentNode source.
	oldSpecificationNode ~= specificationNode ifTrue: [ self changed: #specification ].
	self announceSpecificationChanged.
	oldState ~= self state ifTrue: [
			self changed: #state.
			self announceStateChanged ]
]

{ #category : 'private' }
ViennaAnimation >> state [
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
ViennaAnimation >> state: aDictionary [

	| oldState |
	oldState := self state.
	aDictionary keysAndValuesDo: [ :var :val | self basicAt: var put: (reader parse: val) ].
	object inv.
	self state ~= self state ifTrue: [ self announceStateChanged ]
]

{ #category : 'accessing' }
ViennaAnimation >> transpiledSpecification [

	^ object
]

{ #category : 'class access' }
ViennaAnimation >> transpilerClass [

	^ ViennaVDM2SmalltalkObject
]
