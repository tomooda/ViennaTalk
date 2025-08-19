Class {
	#name : 'ViennaExecutionTraceOperationCallEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'operation',
		'arguments',
		'events'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceOperationCallEvent class >> module: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	^ self new
		  setModule: aString
		  operation: anotherString
		  arguments: anArray
		  events: anArrayOfViennaExecutionTraceEvent;
		  yourself
]

{ #category : 'formatting' }
ViennaExecutionTraceOperationCallEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	aViennaExecutionRecordFormat
		writeCall: operation
		module: module
		args: arguments
		on: aStream.
	anotherBlock cull: self.
	events do: [ :event |
			event
				applyToFormat: aViennaExecutionRecordFormat
				on: aStream
				before: aBlock
				after: anotherBlock ]
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> children [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> events [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> iconName [

	^ #redo
]

{ #category : 'testing' }
ViennaExecutionTraceOperationCallEvent >> isOperationCallEvent [

	^ true
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> operation [

	^ operation
]

{ #category : 'copying' }
ViennaExecutionTraceOperationCallEvent >> postCopy [

	super postCopy.
	arguments := arguments copy.
	events := events copy
]

{ #category : 'private' }
ViennaExecutionTraceOperationCallEvent >> setModule: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	module := aString.
	operation := anotherString.
	arguments := anArray.
	events := anArrayOfViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> source [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: module;
				  nextPut: $`;
				  nextPutAll: operation;
				  nextPut: $(.
			  arguments
				  do: [ :value | value viennaStringOn: stream ]
				  separatedBy: [ stream nextPutAll: ', ' ].
			  stream nextPut: $) ]
]

{ #category : 'private' }
ViennaExecutionTraceOperationCallEvent >> withinModule [

	events := events
		          select: [ :event | module = event module ]
		          thenCollect: #copyWithinModule
]
