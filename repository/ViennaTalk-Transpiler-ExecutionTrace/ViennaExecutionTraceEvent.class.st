Class {
	#name : 'ViennaExecutionTraceEvent',
	#superclass : 'Object',
	#instVars : [
		'module'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'testing' }
ViennaExecutionTraceEvent class >> isAbstract [

	^ self = ViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> children [

	^ #(  )
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> module [

	^ module
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> modulesAndAssignmentsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> source [

	^ self subclassResponsibility
]
