Class {
	#name : 'ViennaExecutionTraceStateEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
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
