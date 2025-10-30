Class {
	#name : 'ViennaExecutionTraceEventRecorder',
	#superclass : 'ViennaExecutionTraceAbstractRecorder',
	#instVars : [
		'forced',
		'paused',
		'eventStack'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Recorder',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Recorder'
}

{ #category : 'accessing' }
ViennaExecutionTraceEventRecorder class >> initialState: aDictionary [

	^ self new
		  initialState: aDictionary;
		  yourself
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> beginRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> call: aString module: anotherString args: anArray [

	(paused not or: [ forced ]) ifTrue: [
			eventStack addLast: (ViennaExecutionTraceOperationCallEvent
					 module: anotherString
					 operation: aString
					 arguments: anArray
					 events: nil) ]
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> endRecording [

	| root |
	root := eventStack first.
	root events: eventStack allButFirst asArray.
	eventStack removeAll.
	eventStack addLast: root
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> forceRecording: aBoolean [

	forced := aBoolean = true
]

{ #category : 'accessing' }
ViennaExecutionTraceEventRecorder >> initialState: aDictionary [

	eventStack first initialState: aDictionary
]

{ #category : 'initialization' }
ViennaExecutionTraceEventRecorder >> initialize [

	super initialize.
	eventStack := OrderedCollection new
		             addFirst: ViennaExecutionTraceRootEvent new;
		             yourself.
	forced := false.
	paused := false
]

{ #category : 'accessing' }
ViennaExecutionTraceEventRecorder >> openWithSpecification: aViennaModularDocumentNode source: aString title: anotherString [

	eventStack first
		specification: aViennaModularDocumentNode;
		source: aString.
	^ (ViennaExecutionTraceEventViewer new
		   specification: aViennaModularDocumentNode;
		   roots: { self output };
		   open) title: anotherString
]

{ #category : 'accessing' }
ViennaExecutionTraceEventRecorder >> openWithTitle: aString [

	eventStack first inspect
]

{ #category : 'accessing' }
ViennaExecutionTraceEventRecorder >> output [

	^ eventStack first
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> pauseRecording [

	paused := true
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> resumeRecording [

	paused := false
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> return: aString module: anotherString value: anObject [

	(paused not or: [ forced ]) ifTrue: [
			| events |
			events := Array streamContents: [ :stream |
					          [
						          | event |
						          event := eventStack last.
						          event isOperationCallEvent and: [
								          event events isNil and: [
									          event operation = aString and: [
										          event module = anotherString ] ] ] ] whileFalse: [
						          stream nextPut: eventStack removeLast ] ].
			eventStack last events:
				(events reversed copyWith: (ViennaExecutionTraceReturnEvent
						  module: anotherString
						  operation: aString
						  returnValue: anObject)) ]
]

{ #category : 'recording' }
ViennaExecutionTraceEventRecorder >> stateDiffBlock: aBlock [

	(paused not or: [ forced ]) ifTrue: [
			| moduleAndAssignments |
			moduleAndAssignments := aBlock value.
			eventStack addLast: (ViennaExecutionTraceAssignmentEvent
					 module: moduleAndAssignments key
					 assignments: moduleAndAssignments value) ]
]
