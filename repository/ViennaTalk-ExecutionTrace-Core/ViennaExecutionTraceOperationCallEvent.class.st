Class {
	#name : 'ViennaExecutionTraceOperationCallEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'operation',
		'arguments',
		'events'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Events',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceOperationCallEvent class >> module: aString operation: anotherString arguments: anArray [

	^ self
		  module: aString
		  operation: anotherString
		  arguments: anArray
		  events: Array new
]

{ #category : 'instance creation' }
ViennaExecutionTraceOperationCallEvent class >> module: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	^ self new
		  setModule: aString
		  operation: anotherString
		  arguments: anArray
		  events: anArrayOfViennaExecutionTraceEvent;
		  yourself
]

{ #category : 'comparing' }
ViennaExecutionTraceOperationCallEvent >> = anObject [

	^ (self shallowEquals: anObject) and: [ events = anObject events ]
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
ViennaExecutionTraceOperationCallEvent >> events: anArrayOfViennaExecutionTraceEvent [

	events := anArrayOfViennaExecutionTraceEvent
]

{ #category : 'comparing' }
ViennaExecutionTraceOperationCallEvent >> hash [

	^ self shallowHash bitXor: events hash
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
ViennaExecutionTraceOperationCallEvent >> poststateFromPrestate: aDictionary [

	^ events inject: aDictionary into: [ :state :event |
			  event prestate: state.
			  event poststate ]
]

{ #category : 'private' }
ViennaExecutionTraceOperationCallEvent >> setModule: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	module := aString.
	operation := anotherString.
	arguments := anArray.
	events := anArrayOfViennaExecutionTraceEvent
]

{ #category : 'comparing' }
ViennaExecutionTraceOperationCallEvent >> shallowEquals: anObject [

	^ (super shallowEquals: anObject) and: [
			  operation = anObject operation and: [
				  arguments = anObject arguments  ]]
]

{ #category : 'comparing' }
ViennaExecutionTraceOperationCallEvent >> shallowHash [

	^ (super shallowHash bitXor: operation hash) bitXor: arguments hash
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
