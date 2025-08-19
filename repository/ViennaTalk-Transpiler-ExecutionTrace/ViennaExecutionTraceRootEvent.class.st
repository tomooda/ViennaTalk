Class {
	#name : 'ViennaExecutionTraceRootEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'specification',
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

{ #category : 'formatting' }
ViennaExecutionTraceRootEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	anotherBlock cull: self.
	events do: [ :event |
			event
				applyToFormat: aViennaExecutionRecordFormat
				on: aStream
				before: aBlock
				after: anotherBlock ]
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
ViennaExecutionTraceRootEvent >> module: aString [

	module := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> openWithTitle: aString [

	^ (ViennaExecutionTraceEventViewer new
		   specification: specification;
		   roots: { self };
		   open) title: aString
]

{ #category : 'copying' }
ViennaExecutionTraceRootEvent >> postCopy [

	super postCopy.
	initial := initial collect: #copy.
	events := events copy
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

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> specification [

	^ specification
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode
]

{ #category : 'private' }
ViennaExecutionTraceRootEvent >> withinModule [

	events := events
		          select: [ :event | module = event module ]
		          thenCollect: #copyWithinModule
]
