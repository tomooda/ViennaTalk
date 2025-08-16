Class {
	#name : 'ViennaExecutionTraceOperationCallEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'operation',
		'arguments',
		'events',
		'modulesAndAssignments'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceOperationCallEvent class >> module: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	^ self new
		  setModule: aString
		  operation: anotherString
		  arguments: anArray
		  events: anArrayOfViennaExecutionTraceEvent;
		  yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> children [

	^ events
]

{ #category : 'private' }
ViennaExecutionTraceOperationCallEvent >> computeModulesAndAssignments [

	| globalState |
	globalState := OrderedDictionary new.
	events do: [ :event |
			event modulesAndAssignmentsDo: [ :mod :var :val |
					(globalState at: mod ifAbsentPut: [ OrderedDictionary new ])
						at: var
						put: val ] ].
	^ globalState
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> events [

	^ events
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> iconName [

	^ #redo
]

{ #category : 'testing' }
ViennaExecutionTraceOperationCallEvent >> isOperationCallEvent [

	^ true
]

{ #category : 'enumerating' }
ViennaExecutionTraceOperationCallEvent >> modulesAndAssignmentsDo: aBlock [

	(modulesAndAssignments ifNil: [
		 modulesAndAssignments := self computeModulesAndAssignments ])
		keysAndValuesDo: [ :mod :dict |
				dict keysAndValuesDo: [ :var :val |
					aBlock value: mod value: var value: val ] ]
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> operation [

	^ operation
]

{ #category : 'private' }
ViennaExecutionTraceOperationCallEvent >> setModule: aString operation: anotherString arguments: anArray events: anArrayOfViennaExecutionTraceEvent [

	module := aString.
	operation := anotherString.
	arguments := anArray.
	events := anArrayOfViennaExecutionTraceEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceOperationCallEvent >> source [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: module;
				  nextPut: $`;
				  nextPutAll: operation;
				  nextPut: $(.
			  arguments
				  do: [ :value | value viennaStringOn: stream ]
				  separatedBy: [ stream nextPutAll: ', ' ].
			  stream nextPut: $) ]
]
