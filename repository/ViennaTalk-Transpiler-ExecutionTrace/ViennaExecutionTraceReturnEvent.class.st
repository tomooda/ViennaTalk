Class {
	#name : 'ViennaExecutionTraceReturnEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'module',
		'operation',
		'returnValue'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> children [

	^ #(  )
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> module [

	^ module
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> module: aString [

	module := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> operation [

	^ operation
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> operation: aString [

	operation := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> returnValue [

	^ returnValue
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> returnValue: anObject [

	returnValue := anObject
]
