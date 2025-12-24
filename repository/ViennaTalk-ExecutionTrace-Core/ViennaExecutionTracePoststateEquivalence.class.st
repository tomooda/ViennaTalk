Class {
	#name : 'ViennaExecutionTracePoststateEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-ExecutionTrace-Core-Query',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTracePoststateEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent poststate
	  = anotherViennaExecutionTraceEvent poststate
]
