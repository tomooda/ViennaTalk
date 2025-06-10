Class {
	#name : 'ViennaMutationTestResultItem',
	#superclass : 'ViennaTestResultItem',
	#instVars : [
		'mutation',
		'baseSpecification',
		'mutatedSpecification',
		'isRunning',
		'isSurviving',
		'isKilled',
		'diffSet'
	],
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'instance creation' }
ViennaMutationTestResultItem class >> mutation: aViennaMutation from: aViennaNode to: anotherViennaNode [

	^ self new
		  mutation: aViennaMutation;
		  baseSpecification: aViennaNode;
		  mutatedSpecification: anotherViennaNode;
		  yourself
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> baseSpecification [

	^ baseSpecification
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> baseSpecification: aViennaNode [

	baseSpecification := aViennaNode.
	self flushDiffSet
]

{ #category : 'private' }
ViennaMutationTestResultItem >> basicRunSpecification: aViennaNode [

	| animation |
	animation := ViennaAnimation transpiler
		             specification: aViennaNode;
		             yourself.
	aViennaNode testOperationsDo: [ :operation |
		animation
			runTestOperation: operation identifier
			module: operation module identifier.
		Processor yield ].
	aViennaNode namedTracesDo: [ :namedTrace |
		animation
			runTrace: namedTrace identifier
			module: namedTrace module identifier
			do: [  ]
			onError: [ :ex | ex pass ].
		Processor yield ]
]

{ #category : 'menus' }
ViennaMutationTestResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> diffSet [

	^ diffSet ifNil: [
		  (baseSpecification notNil and: [ mutatedSpecification notNil ])
			  ifTrue: [
				  diffSet := (ViennaNodeDiffSet
					              from: baseSpecification
					              to: mutatedSpecification)
					             condenseChanges;
					             yourself ]
			  ifFalse: [ nil ] ]
]

{ #category : 'private' }
ViennaMutationTestResultItem >> flushDiffSet [

	diffSet := nil.
	self diffSet
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> icon [

	self isRunning ifTrue: [ ^ self iconNamed: #smallUpdate ].
	self isKilled ifTrue: [ ^ self successIcon ].
	self isSurviving ifTrue: [ ^ self errorIcon ].
	^ self offIcon
]

{ #category : 'initialization' }
ViennaMutationTestResultItem >> initialize [

	super initialize.
	isKilled := false.
	isSurviving := false.
	isRunning := false
]

{ #category : 'testing' }
ViennaMutationTestResultItem >> isKilled [

	^ isKilled = true
]

{ #category : 'testing' }
ViennaMutationTestResultItem >> isRunning [

	^ isRunning = true
]

{ #category : 'testing' }
ViennaMutationTestResultItem >> isSurviving [

	^ isSurviving = true
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> message [

	self isRunning ifTrue: [ ^ 'Running...' ].
	self isKilled ifTrue: [ ^ 'Killed' ].
	self isSurviving ifTrue: [ ^ 'Surviving' ].
	^ ''
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> mutatedSpecification [

	^ mutatedSpecification
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> mutatedSpecification: aViennaNode [

	mutatedSpecification := aViennaNode.
	self flushDiffSet
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> mutation [

	^ mutation
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> mutation: aViennaMutation [

	mutation := aViennaMutation
]

{ #category : 'operations' }
ViennaMutationTestResultItem >> run [

	self startRunning.
	[
	| mutatedAnimation |
	mutatedAnimation := ViennaAnimation transpiler
		                    specification: mutatedSpecification;
		                    yourself.
	[
	self basicRunSpecification: mutatedSpecification.
	isSurviving := true ]
		on: Exception
		do: [ :ex |
			isKilled := true.
			ex return: nil ] ] ensure: [ self stopRunning ]
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> sortingOrder [

	^ self isSurviving
		  ifTrue: [ 2 ]
		  ifFalse: [ 0 ]
]

{ #category : 'operations' }
ViennaMutationTestResultItem >> startRunning [

	isRunning := true
]

{ #category : 'operations' }
ViennaMutationTestResultItem >> stopRunning [

	isRunning := false
]

{ #category : 'accessing' }
ViennaMutationTestResultItem >> testName [

	^ (self diffSet
		   ifNotNil: [ :diff | ',' join: diff changedGlobalNames ]
		   ifNil: [ '-' ])
	  ,
	  (self mutation ifNotNil: [ :m | ' (' , m name , ')' ] ifNil: [ '' ])
]
