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

{ #category : 'comparing' }
ViennaExecutionTraceRootEvent >> = anObject [

	^ (self shallowEquals: anObject) and: [ events = anObject events ]
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
ViennaExecutionTraceRootEvent >> events: anArrayOfViennaExecutionTraceEvent [

	events := anArrayOfViennaExecutionTraceEvent.
	self prestate: OrderedDictionary new
]

{ #category : 'comparing' }
ViennaExecutionTraceRootEvent >> hash [

	^ self shallowHash bitXor: events hash
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

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> initialState [

	| initialState |
	initialState := OrderedDictionary new.
	self initialModulesAndAssignmentsDo: [ :mod :var :val |
			(initialState at: mod ifAbsentPut: [ OrderedDictionary new ])
				at: var
				put: val ].
	^ initialState
]

{ #category : 'accessing' }
ViennaExecutionTraceRootEvent >> initialState: aDictionary [

	initial := aDictionary keys asArray collect: [ :moduleName |
			           aDictionary
				           at: moduleName
				           ifPresent: [ :moduleStateDictionary |
						           ViennaExecutionTraceAssignmentEvent
							           module: moduleName
							           assignments:
							           moduleStateDictionary associations asArray ] ].
	self prestate: OrderedDictionary new
]

{ #category : 'initialization' }
ViennaExecutionTraceRootEvent >> initialize [

	super initialize.
	events := Array new.
	initial := Array new
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
ViennaExecutionTraceRootEvent >> poststateFromPrestate: aDictionary [

	^ events inject: self initialState into: [ :state :event |
			  event prestate: state.
			  event poststate ]
]

{ #category : 'private' }
ViennaExecutionTraceRootEvent >> setInitial: anArrayOfViennaExecutionTraceAssignmentEvents events: anArrayOfViennaExecutionTraceEvents [

	initial := anArrayOfViennaExecutionTraceAssignmentEvents.
	events := anArrayOfViennaExecutionTraceEvents.
	self prestate: OrderedDictionary new
]

{ #category : 'comparing' }
ViennaExecutionTraceRootEvent >> shallowEquals: anObject [

	^ (super shallowEquals: anObject) and: [
			  specification = anObject specification and: [
				  source = anObject source and: [ initial = anObject initial ] ] ]
]

{ #category : 'comparing' }
ViennaExecutionTraceRootEvent >> shallowHash [

	^ ((super shallowHash bitXor: specification hash) bitXor: source hash)
		  bitXor: initial hash
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
