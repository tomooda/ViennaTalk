Class {
	#name : 'ViennaExecutionTraceEquivalence',
	#superclass : 'Object',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'testing' }
ViennaExecutionTraceEquivalence >> between: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaExecutionTraceEquivalence >> equivalenceBetween: anObject and: anotherObject under: projectionBlock [

	^ (projectionBlock value: anObject)
	  = (projectionBlock value: anotherObject)
]

{ #category : 'testing' }
ViennaExecutionTraceEquivalence >> equivalenceBetweenArrays: anArray and: anotherArray under: projectionBlock [

	^ anArray size = anotherArray size and: [
			  (1 to: anArray size) allSatisfy: [ :index |
					  (projectionBlock value: (anArray at: index))
					  = (projectionBlock value: (anotherArray at: index)) ] ]
]

{ #category : 'testing' }
ViennaExecutionTraceEquivalence >> equivalenceBetweenArrays: anArray and: anotherArray with: equivalenceBlock [

	^ anArray size = anotherArray size and: [
			  (1 to: anArray size) allSatisfy: [ :index |
					  equivalenceBlock
						  value: (anArray at: index)
						  value: (anotherArray at: index) ] ]
]

{ #category : 'private' }
ViennaExecutionTraceEquivalence >> eventsFrom: aViennaExecutionTraceEvent and: anotherViennaExecutionTraceEvent suchthat: aBlock do: anotherBlock [

	| events1 events2 |
	events1 := Array streamContents: [ :stream |
			           aViennaExecutionTraceEvent do: [ :event |
				           (aBlock value: event) ifTrue: [ stream nextPut: event ] ] ].
	events2 := Array streamContents: [ :stream |
			           anotherViennaExecutionTraceEvent do: [ :event |
				           (aBlock value: event) ifTrue: [ stream nextPut: event ] ] ].
	^ anotherBlock value: events1 value: events2
]

{ #category : 'testing' }
ViennaExecutionTraceEquivalence >> shallowEqualityBetweenArrays: anArray and: anotherArray [

	^ anArray size = anotherArray size and: [
			  (1 to: anArray size) allSatisfy: [ :index |
				  (anArray at: index) shallowEquals: (anotherArray at: index) ] ]
]
