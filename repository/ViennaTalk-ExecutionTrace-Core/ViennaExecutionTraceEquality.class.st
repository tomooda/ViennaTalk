Class {
	#name : 'ViennaExecutionTraceEquality',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-ExecutionTrace-Core-Query',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceEquality >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent = anotherViennaExecutionTraceEvent
]
