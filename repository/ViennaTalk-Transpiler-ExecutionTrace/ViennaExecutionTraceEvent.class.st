Class {
	#name : 'ViennaExecutionTraceEvent',
	#superclass : 'Object',
	#instVars : [
		'module',
		'poststate'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'testing' }
ViennaExecutionTraceEvent class >> isAbstract [

	^ self = ViennaExecutionTraceEvent
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> allAssignmentChildrenDo: aBlock [

	self children do: [ :event | event allAssignmentChildrenDo: aBlock ]
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> allEventsDo: aBlock [

	aBlock value: self.
	self children do: [ :event | event allEventsDo: aBlock ]
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> allTipChildrenDo: aBlock [

	self children do: [ :event | event allTipChildrenDo: aBlock ]
]

{ #category : 'evaluating' }
ViennaExecutionTraceEvent >> applyAssignmentTo: aViennaTranspiledModularDocument [
	
]

{ #category : 'formatting' }
ViennaExecutionTraceEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream [

	self
		applyToFormat: aViennaExecutionRecordFormat
		on: aStream
		before: [ :event |  ]
		after: [ :event |  ]
]

{ #category : 'formatting' }
ViennaExecutionTraceEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> children [

	^ #(  )
]

{ #category : 'copying' }
ViennaExecutionTraceEvent >> copyWithinModule [

	^ self copy
		  withinModule;
		  yourself
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> globalWrites [

	| globalWrites |
	globalWrites := OrderedDictionary new.
	self allAssignmentChildrenDo: [ :assignmentEvent |
			| localWrites |
			localWrites := globalWrites
				               at: assignmentEvent module
				               ifAbsentPut: [ OrderedDictionary new ].
			assignmentEvent assignmentsDo: [ :var :val |
				localWrites at: var put: val ] ].
	^ globalWrites
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> iconName [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaExecutionTraceEvent >> isAssignmentEvent [

	^ false
]

{ #category : 'testing' }
ViennaExecutionTraceEvent >> isOperationCallEvent [

	^ false
]

{ #category : 'testing' }
ViennaExecutionTraceEvent >> isReturnEvent [

	^ false
]

{ #category : 'testing' }
ViennaExecutionTraceEvent >> isRootEvent [

	^ false
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> module [

	^ module
]

{ #category : 'enumerating' }
ViennaExecutionTraceEvent >> modulesAndAssignmentsDo: aBlock [

	self globalWrites keysAndValuesDo: [ :mod :local |
			local keysAndValuesDo: [ :var :val |
				aBlock value: mod value: var value: val ] ]
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> poststate [

	^ poststate
]

{ #category : 'private' }
ViennaExecutionTraceEvent >> poststateFromPrestate: aDictionary [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> prestate: aDictionary [

	poststate := self poststateFromPrestate: aDictionary
]

{ #category : 'accessing' }
ViennaExecutionTraceEvent >> source [

	^ self subclassResponsibility
]

{ #category : 'private' }
ViennaExecutionTraceEvent >> withinModule [

	^ self subclassResponsibility
]
