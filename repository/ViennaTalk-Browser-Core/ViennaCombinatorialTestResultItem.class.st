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
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem class >> on: aViennaNamedTraceNode [

	^ self new
		  initializeWith: aViennaNamedTraceNode;
		  yourself
]

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> addFailure: aViennaTraceException [

	failures add: aViennaTraceException
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> exception [

	^ failures ifNotEmpty: [ failures first exception ] ifEmpty: [ nil ]
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> numFailures [

	^ failures size
]

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> numSuccesses [

	^ self numTests - self numFailures
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> trace [

	^ trace
]

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> trace: aString [

	trace := aString
]

{ #category : 'as yet unclassified' }
ViennaCombinatorialTestResultItem >> traceNode [

	^ traceNode
]
