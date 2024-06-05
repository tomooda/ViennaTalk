Class {
	#name : 'ViennaCombinatorialTestResultItem',
	#superclass : 'ViennaTestResultItem',
	#instVars : [
		'trace',
		'failures',
		'numTests',
		'isRunning',
		'traceNode'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'instance creation' }
ViennaCombinatorialTestResultItem class >> on: aViennaNamedTraceNode [

	^ self new
		  initializeWith: aViennaNamedTraceNode;
		  yourself
]

{ #category : 'adding' }
ViennaCombinatorialTestResultItem >> addFailure: aViennaTraceException [

	failures add: aViennaTraceException
]

{ #category : 'adding' }
ViennaCombinatorialTestResultItem >> addTest [

	numTests := numTests + 1
]

{ #category : 'menus' }
ViennaCombinatorialTestResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	aSpMenuPresenter addItem: [ :item |
		item
			name: 'Open failures';
			action: [ (ViennaCombinatorialTestResultViewer on: self) open ] ]
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> exception [

	^ failures ifNotEmpty: [ failures first exception ] ifEmpty: [ nil ]
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> failures [

	^ failures
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> icon [

	^ self isRunning
		  ifTrue: [ self iconNamed: #smallUpdate ]
		  ifFalse: [
			  self numTests = 0
				  ifTrue: [ self offIcon ]
				  ifFalse: [
					  self numFailures > 0
						  ifTrue: [ self errorIcon ]
						  ifFalse: [ self successIcon ] ] ]
]

{ #category : 'initialization' }
ViennaCombinatorialTestResultItem >> initializeWith: aViennaNamedTraceNode [

	super initialize.
	module := aViennaNamedTraceNode module
		          ifNotNil: #identifier
		          ifNil: [ 'DEFAULT' ].
	trace := aViennaNamedTraceNode identifier.
	traceNode := aViennaNamedTraceNode.
	numTests := 0.
	failures := OrderedCollection new.
	isRunning := false
]

{ #category : 'testing' }
ViennaCombinatorialTestResultItem >> isRunning [

	^ isRunning
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> message [

	^ String streamContents: [ :stream |
		  self isRunning
			  ifTrue: [ stream nextPutAll: 'Running...' ]
			  ifFalse: [
				  self numTests > 0 ifTrue: [
					  stream nextPutAll: 'Found '.
					  self numFailures printOn: stream.
					  stream nextPutAll: ' failures out of '.
					  self numTests printOn: stream.
					  stream nextPutAll: ' tests' ] ] ]
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> numFailures [

	^ failures size
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> numSuccesses [

	^ self numTests - self numFailures
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> numTests [

	^ numTests
]

{ #category : 'operations' }
ViennaCombinatorialTestResultItem >> run [

	self startRunning.
	[
	traceNode
		run: [
			self addTest.
			Processor yield ]
		onError: [ :ex |
			self addFailure: ex.
			ex resume ] ] ensure: [ self stopRunning ]
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> sortingOrder [

	^ self numFailures > 0
		  ifTrue: [ 2 ]
		  ifFalse: [ 0 ]
]

{ #category : 'operations' }
ViennaCombinatorialTestResultItem >> startRunning [

	isRunning := true
]

{ #category : 'operations' }
ViennaCombinatorialTestResultItem >> stopRunning [

	isRunning := false
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> testName [

	^ self trace
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> trace [

	^ trace
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> trace: aString [

	trace := aString
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> traceNode [

	^ traceNode
]
