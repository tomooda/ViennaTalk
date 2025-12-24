Class {
	#name : 'ViennaExecutionTraceRootEventTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-ExecutionTrace-Tests',
	#package : 'ViennaTalk-ExecutionTrace-Tests'
}

{ #category : 'tests' }
ViennaExecutionTraceRootEventTest >> testInitialEvents [

	| event |
	event := ViennaExecutionTraceRootEvent
		         initial: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> nil) }).
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Bar'
					          assignments: {
							          ('baz' -> #quuux).
							          ('quuux' -> 1) }) }
		         events: {
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Foo'
					          assignments: { ('quuux' -> #quuux) }).
				         (ViennaExecutionTraceAssignmentEvent
					          module: 'Bar'
					          assignments: { ('baz' -> 'quuux') }) }.
	self assert: event poststate equals: {
			('Foo' -> { ('quuux' -> #quuux) } asOrderedDictionary).
			('Bar' -> {
				 ('baz' -> 'quuux').
				 ('quuux' -> 1) } asOrderedDictionary) } asOrderedDictionary
]

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
