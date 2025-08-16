Class {
	#name : 'ViennaExecutionTraceRootEventTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaExecutionTraceRootEventTest >> testModulesAndAssignmentsDo [

	| event |
	event := ViennaExecutionTraceRootEvent
		         initial: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> nil) }).
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Bar'
					          assignments: { ('baz' -> #quuux) }) }
		         events: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> #quuux) }).
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Bar'
					          assignments: { ('baz' -> 'quuux') }) }.
	self
		assert: (Array streamContents: [ :stream |
					 event modulesAndAssignmentsDo: [ :module :var :value |
							 stream nextPut: {
									 module.
									 var.
									 value } ] ])
		equals: {
				{ 'Foo'. 'quuux'. #quuux }.
				{ 'Bar'. 'baz'. 'quuux' } }
]
