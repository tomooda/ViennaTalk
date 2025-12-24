Class {
	#name : 'ViennaExecutionTraceOperationCallReturnEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-ExecutionTrace-Core-Query',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceOperationCallReturnEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ self
		  eventsFrom: aViennaExecutionTraceEvent
		  and: anotherViennaExecutionTraceEvent
		  suchthat: [ :event |
		  event isOperationCallEvent or: [ event isReturnEvent ] ]
		  do: [ :events1 :events2 |
			  self shallowEqualityBetweenArrays: events1 and: events2 ]
]
