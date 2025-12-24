Class {
	#name : 'ViennaExecutionTraceEquality',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceEquality >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent = anotherViennaExecutionTraceEvent
]
