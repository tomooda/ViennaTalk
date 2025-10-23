Class {
	#name : 'ViennaExecutionTracePoststateEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTracePoststateEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent poststate
	  = anotherViennaExecutionTraceEvent poststate
]
