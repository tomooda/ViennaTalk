Class {
	#name : 'ViennaExecutionTraceInitializationEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'assignmentEvents'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'accessing' }
ViennaExecutionTraceInitializationEvent >> assignmentEvents [

	^ assignmentEvents
]

{ #category : 'accessing' }
ViennaExecutionTraceInitializationEvent >> assignmentEvents: anArrayOfViennaExecutionTraceAssignmentEvent [

	assignmentEvents := anArrayOfViennaExecutionTraceAssignmentEvent
]
