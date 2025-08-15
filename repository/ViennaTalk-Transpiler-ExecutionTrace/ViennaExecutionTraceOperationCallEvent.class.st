Class {
	#name : 'ViennaExecutionTraceOperationCallEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'module',
		'operation',
		'arguments',
		'events'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> arguments: anArray [

	arguments := anArray
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

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> module [

	^ module
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> module: aString [

	module := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> operation [

	^ operation
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> operation: aString [

	operation := aString
]
