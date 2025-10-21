Class {
	#name : 'ViennaExecutionTraceEquivalence',
	#superclass : 'Object',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'comparing' }
ViennaExecutionTraceEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent
		  isEquivalentTo: anotherViennaExecutionTraceEvent
		  under: self
]

{ #category : 'comparing' }
ViennaExecutionTraceEquivalence >> betweenAssignments: aViennaExecutionTraceAssignmentEvent and: anotherViennaExecutionTraceAssignmentEvent [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
ViennaExecutionTraceEquivalence >> betweenOperationCalls: aViennaExecutionTraceOperationCallEvent and: anotherViennaExecutionTraceOperationCallEvent [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
ViennaExecutionTraceEquivalence >> betweenReturns: aViennaExecutionTraceReturnEvent and: anotherViennaExecutionTraceReturnEvent [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
ViennaExecutionTraceEquivalence >> betweenRoots: aViennaExecutionTraceRootEvent and: anotherViennaExecutionTraceRootEvent [

	^ self subclassResponsibility
]
