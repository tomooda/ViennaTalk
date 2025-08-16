Class {
	#name : 'ViennaExecutionTraceReturnEventTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaExecutionTraceReturnEventTest >> testModulesAndAssignmentsDo [

	| event |
	event := ViennaExecutionTraceReturnEvent
		         module: 'Foo'
		         operation: 'bar'
		         returnValue: { 'baz'. #quuux }.
	self assert: (Array streamContents: [ :stream |
				 event modulesAndAssignmentsDo: [ :module :var :value |
						 stream nextPut: {
								 module.
								 var.
								 value } ] ]) isEmpty
]

{ #category : 'tests' }
ViennaExecutionTraceReturnEventTest >> testSource [

	| event |
	event := ViennaExecutionTraceReturnEvent
		         module: 'Foo'
		         operation: 'bar'
		         returnValue: { 'baz'. #quuux }.
	self assert: event source equals: 'return mk_("baz", <quuux>)'
]
