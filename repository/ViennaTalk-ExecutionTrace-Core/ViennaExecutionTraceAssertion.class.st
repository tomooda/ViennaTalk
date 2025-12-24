Class {
	#name : 'ViennaExecutionTraceAssertion',
	#superclass : 'Object',
	#instVars : [
		'event',
		'expressionSource'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Query',
	#package : 'ViennaTalk-ExecutionTrace-Core',
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
