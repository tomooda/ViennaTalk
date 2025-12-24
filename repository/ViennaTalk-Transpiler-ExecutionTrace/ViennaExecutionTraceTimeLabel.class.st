Class {
	#name : 'ViennaExecutionTraceTimeLabel',
	#superclass : 'Object',
	#instVars : [
		'event',
		'name'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabel >> annotationSource [

	^ '--@time ' , name
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabel >> event [

	^ event
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabel >> event: aViennaExecutionTraceEvent [

	event := aViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabel >> name [

	^ name
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabel >> name: aString [

	name := aString
]
