Class {
	#name : 'ViennaExecutionTraceAssignmentEventTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaExecutionTraceAssignmentEventTest >> testModulesAndAssignmentsDo [

	| event |
	event := ViennaExecutionTraceAssignmentEvent
		         module: 'Foo'
		         assignments: {
				         ('bar' -> nil).
				         ('baz' -> #quuux) }.
	self
		assert: (Array streamContents: [ :stream |
					 event modulesAndAssignmentsDo: [ :module :var :value |
							 stream nextPut: {
									 module.
									 var.
									 value } ] ])
		equals: {
				{ 'Foo'. 'bar'. nil }.
				{ 'Foo'. 'baz'. #quuux } }
]

{ #category : 'tests' }
ViennaExecutionTraceAssignmentEventTest >> testSource [

	| event |
	event := ViennaExecutionTraceAssignmentEvent
		         module: 'Foo'
		         assignments: { ('bar' -> { 'baz'. #quuux }) }.
	self assert: event source equals: 'bar := mk_("baz", <quuux>)'.
	event := ViennaExecutionTraceAssignmentEvent
		         module: 'Foo'
		         assignments: {
				         ('bar' -> nil).
				         ('baz' -> #quuux) }.
	self
		assert: event source
		equals: 'atomic(bar := nil; baz := <quuux>)'
]
