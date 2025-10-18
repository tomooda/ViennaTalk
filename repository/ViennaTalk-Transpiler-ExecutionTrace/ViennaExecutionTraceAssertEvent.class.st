Class {
	#name : 'ViennaExecutionTraceAssertEvent',
	#superclass : 'Object',
	#instVars : [
		'expressionSource'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'formatting' }
ViennaExecutionTraceAssertEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	aViennaExecutionRecordFormat
		writeAssert: expressionSource
		on: aStream.
	anotherBlock cull: self
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertEvent >> expressionSource [

	^ expressionSource
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertEvent >> expressionSource: aString [

	expressionSource := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertEvent >> iconName [

	^ #flag
]

{ #category : 'accessing' }
ViennaExecutionTraceAssertEvent >> source [

	^ '--@assert ' , expressionSource
]

{ #category : 'private' }
ViennaExecutionTraceAssertEvent >> withinModule [


]
