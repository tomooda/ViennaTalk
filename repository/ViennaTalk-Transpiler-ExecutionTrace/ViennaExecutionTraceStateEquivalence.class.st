Class {
	#name : 'ViennaExecutionTraceStateEquivalence',
	#superclass : 'ViennaExecutionTraceEquivalence',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceStateEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	| events1 events2 |
	events1 := Array streamContents: [ :stream |
			           aViennaExecutionTraceEvent do: [ :event |
					           (event isRootEvent or: [ event isAssignmentEvent ])
						           ifTrue: [ stream nextPut: event ] ] ].
	events2 := Array streamContents: [ :stream |
			           anotherViennaExecutionTraceEvent do: [ :event |
					           (event isRootEvent or: [ event isAssignmentEvent ])
						           ifTrue: [ stream nextPut: event ] ] ].
	events1 size = events2 size ifFalse: [ ^ false ].
	events1 with: events2 do: [ :event1 :event2 |
		event1 poststate = event2 poststate ifFalse: [ ^ false ] ].
	^ true
]
