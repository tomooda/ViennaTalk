Class {
	#name : 'ViennaExecutionTraceAssertion',
	#superclass : 'Object',
	#instVars : [
		'event',
		'expressionSource'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'accessing' }
ViennaExecutionTraceAssertion >> annotationSource [

	^ '--@assert ' , expressionSource
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertion >> event [

	^ event
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertion >> event: aViennaExecutionTraceEvent [

	event := aViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertion >> expressionSource [

	^ expressionSource
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertion >> expressionSource: aString [

	expressionSource := aString
]
