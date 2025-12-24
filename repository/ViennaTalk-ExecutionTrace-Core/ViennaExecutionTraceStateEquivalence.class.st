Class {
	#name : 'ViennaExecutionTraceStateEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-ExecutionTrace-Core-Query',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceStateEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ self
		  eventsFrom: aViennaExecutionTraceEvent
		  and: anotherViennaExecutionTraceEvent
		  suchthat: [ :event |
		  event isRootEvent or: [ event isAssignmentEvent ] ]
		  do: [ :events1 :events2 |
			  self
				  equivalenceBetweenArrays: events1
				  and: events2
				  under: #poststate ]
]
