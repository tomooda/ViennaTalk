Class {
	#name : 'ViennaCombinatorialTestResultItem',
	#superclass : 'ViennaTestResultItem',
	#instVars : [
		'trace',
		'failures',
		'numSuccesses',
		'isRunning'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'adding' }
ViennaCombinatorialTestResultItem >> addFailure: aViennaTraceException [

	failures add: aViennaTraceException
]

{ #category : 'adding' }
ViennaCombinatorialTestResultItem >> addSuccess [

	numSuccesses := numSuccesses + 1
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
ViennaCombinatorialTestResultItem >> initialize [

	super initialize.
	module := 'DEFAULT'.
	trace := '-'.
	numSuccesses := 0.
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

	^ numSuccesses
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultItem >> numTests [

	^ self numSuccesses + self numFailures
]

{ #category : 'operations' }
ViennaCombinatorialTestResultItem >> run: aBlock [

	self startRunning.
	aBlock ensure: [ self stopRunning ]
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
