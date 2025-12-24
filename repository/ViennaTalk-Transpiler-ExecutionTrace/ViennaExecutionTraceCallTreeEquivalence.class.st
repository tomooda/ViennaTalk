Class {
	#name : 'ViennaExecutionTraceCallTreeEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceCallTreeEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ self
		  eventsFrom: aViennaExecutionTraceEvent
		  and: anotherViennaExecutionTraceEvent
		  suchthat: [ :event |
		  event isOperationCallEvent or: [ event isReturnEvent ] ]
		  do: [ :events1 :events2 |
				  self
					  equivalenceBetweenArrays: events1
					  and: events2
					  with: [ :event1 :event2 |
							  event1 isOperationCallEvent = event2 isOperationCallEvent
								  and: [
										  event1 module = event2 module and: [
											  event1 operation = event2 operation ] ] ] ]
]
