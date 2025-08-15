Class {
	#name : 'ViennaExecutionTraceAssignmentEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'module',
		'assignments'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> assignments [

	^ assignments
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> assignments: anArrayOfString [

	assignments := anArrayOfString
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> module [

	^ module
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> module: aString [

	module := aString
]
