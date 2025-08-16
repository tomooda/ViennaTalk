Class {
	#name : 'ViennaExecutionTraceRootEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'source',
		'events',
		'modulesAndAssignments',
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

{ #category : 'private' }
ViennaExecutionTraceRootEvent >> computeModulesAndAssignments [

	| globalState |
	globalState := OrderedDictionary new.
	initial do: [ :assignment |
			assignment modulesAndAssignmentsDo: [ :mod :var :val |
					(globalState at: mod ifAbsentPut: [ OrderedDictionary new ])
						at: var
						put: val ] ].
	events do: [ :event |
			event modulesAndAssignmentsDo: [ :mod :var :val |
					(globalState at: mod ifAbsentPut: [ OrderedDictionary new ])
						at: var
						put: val ] ].
	^ globalState
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

{ #category : 'testing' }
ViennaExecutionTraceRootEvent >> isRootEvent [

	^ true
]

{ #category : 'enumerating' }
ViennaExecutionTraceRootEvent >> modulesAndAssignmentsDo: aBlock [

	(modulesAndAssignments ifNil: [
		 modulesAndAssignments := self computeModulesAndAssignments ])
		keysAndValuesDo: [ :mod :dict |
				dict keysAndValuesDo: [ :var :val |
					aBlock value: mod value: var value: val ] ]
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
