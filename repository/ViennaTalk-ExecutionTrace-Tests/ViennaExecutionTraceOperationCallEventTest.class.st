Class {
	#name : 'ViennaExecutionTraceOperationCallEventTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-ExecutionTrace-Tests',
	#package : 'ViennaTalk-ExecutionTrace-Tests'
}

{ #category : 'tests' }
ViennaExecutionTraceOperationCallEventTest >> testModulesAndAssignmentsDo [

	| event |
	event := ViennaExecutionTraceOperationCallEvent
		         module: 'Foo'
		         operation: 'bar'
		         arguments: { 'baz'. #quuux }
		         events: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> #quuux) }).
				         (ViennaExecutionTraceReturnEvent
					          module: 'Foo'
					          operation: 'bar'
					          returnValue: #quuux) }.
	self
		assert: (Array streamContents: [ :stream |
					 event modulesAndAssignmentsDo: [ :module :var :value |
							 stream nextPut: {
									 module.
									 var.
									 value } ] ])
		equals: { { 'Foo'. 'quuux'. #quuux } }
]

{ #category : 'tests' }
ViennaExecutionTraceOperationCallEventTest >> testSource [

	| event |
	event := ViennaExecutionTraceOperationCallEvent
		         module: 'Foo'
		         operation: 'bar'
		         arguments: { 'baz'. #quuux }
		         events: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> #quuux) }).
				         (ViennaExecutionTraceReturnEvent
					          module: 'Foo'
					          operation: 'bar'
					          returnValue: #quuux) }.
	self assert: event source equals: 'Foo`bar("baz", <quuux>)'
]
