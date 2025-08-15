Class {
	#name : 'ViennaExecutionTraceRootEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'module',
		'source',
		'events'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> children [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> events [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> events: anArrayOfViennaExecutionTraceEvent [

	events := anArrayOfViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> module [

	^ module
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> module: aString [

	module := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> source [

	^ source
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> source: aString [

	source := aString
]
