Class {
	#name : 'ViennaExecutionTraceRootEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'source',
		'events',
		'initial'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceRootEvent class >> initial: anArrayOfViennaExecutionTraceAssignmentEvents events: anArrayOfViennaExecutionTraceEvents [

	^ self new
		  setInitial:
			  anArrayOfViennaExecutionTraceAssignmentEvents
		  events: anArrayOfViennaExecutionTraceEvents;
		  yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> children [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> events [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> iconName [

	^ #scriptManager
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> initial [

	^ initial
]

{ #category : 'enumerating' }
ViennaExecutionTraceRootEvent >> initialModulesAndAssignmentsDo: aBlock [

	initial do: [ :assign | assign modulesAndAssignmentsDo: aBlock ]
]

{ #category : 'testing' }
ViennaExecutionTraceRootEvent >> isRootEvent [

	^ true
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> openWithTitle: aString [

	^ (ViennaExecutionTraceEventViewer new
		   roots: { self };
		   open) title: aString
]

{ #category : 'private' }
ViennaExecutionTraceRootEvent >> setInitial: anArrayOfViennaExecutionTraceAssignmentEvents events: anArrayOfViennaExecutionTraceEvents [

	initial := anArrayOfViennaExecutionTraceAssignmentEvents.
	events := anArrayOfViennaExecutionTraceEvents
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> source [

	^ source
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> source: aString [

	source := aString
]
