Class {
	#name : 'ViennaExecutionTraceAssignmentEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'assignments'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceAssignmentEvent class >> module: aString assignments: anArrayOfAssociation [

	^ self new
		  setModule: aString assignments: anArrayOfAssociation;
		  yourself
]

{ #category : 'enumerating' }
ViennaExecutionTraceAssignmentEvent >> allAssignmentChildrenDo: aBlock [

	aBlock value: self
]

{ #category : 'enumerating' }
ViennaExecutionTraceAssignmentEvent >> allTipChildrenDo: aBlock [

	aBlock value: self
]

{ #category : 'evaluating' }
ViennaExecutionTraceAssignmentEvent >> applyAssignmentTo: aViennaTranspiledModularDocument [

	(aViennaTranspiledModularDocument at: module) ifNotNil: [
			:transpiledModule |
			self assignmentsDo: [ :var :val |
				transpiledModule basicInstVarNamed: var put: val ] ]
]

{ #category : 'formatting' }
ViennaExecutionTraceAssignmentEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	aViennaExecutionRecordFormat
		writeStateDiffBlock: module -> assignments
		on: aStream.
	anotherBlock cull: self
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> assignments [

	^ assignments
]

{ #category : 'enumerating' }
ViennaExecutionTraceAssignmentEvent >> assignmentsDo: aBlock [

	assignments do: [ :assoc |
		aBlock value: assoc key value: assoc value ]
]

{ #category : 'enumerating' }
ViennaExecutionTraceAssignmentEvent >> globalWrites [

	^ { (module -> assignments asOrderedDictionary) } asOrderedDictionary
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> iconName [

	^ #edit
]

{ #category : 'testing' }
ViennaExecutionTraceAssignmentEvent >> isAssignmentEvent [

	^ true
]

{ #category : 'enumerating' }
ViennaExecutionTraceAssignmentEvent >> modulesAndAssignmentsDo: aBlock [

	assignments do: [ :assoc |
		aBlock value: module value: assoc key value: assoc value ]
]

{ #category : 'copying' }
ViennaExecutionTraceAssignmentEvent >> postCopy [

	super postCopy.
	assignments := assignments copy
]

{ #category : 'private' }
ViennaExecutionTraceAssignmentEvent >> poststateFromPrestate: aDictionary [

	| moduleState |
	moduleState := aDictionary
		               at: module
		               ifPresent: [ :state | state copy ]
		               ifAbsent: [ OrderedDictionary new ].
	self assignmentsDo: [ :var :val | moduleState at: var put: val ].
	^ aDictionary copy
		  at: module put: moduleState;
		  yourself
]

{ #category : 'private' }
ViennaExecutionTraceAssignmentEvent >> setModule: aString assignments: anArrayOfAssociation [

	module := aString.
	assignments := anArrayOfAssociation
]

{ #category : 'comparing' }
ViennaExecutionTraceAssignmentEvent >> shallowEquals: anObject [

	^ (super shallowEquals: anObject) and: [ assignments = anObject assignments ]
]

{ #category : 'comparing' }
ViennaExecutionTraceAssignmentEvent >> shallowHash [

	^ super shallowHash bitXor: assignments hash
]

{ #category : 'accessing' }
ViennaExecutionTraceAssignmentEvent >> source [

	^ assignments ifEmpty: [ 'skip' ] ifNotEmpty: [
			  String streamContents: [ :stream |
					  assignments size > 1 ifTrue: [ stream nextPutAll: 'atomic(' ].
					  assignments
						  do: [ :assoc |
								  stream
									  nextPutAll: assoc key;
									  nextPutAll: ' := '.
								  assoc value viennaStringOn: stream ]
						  separatedBy: [ stream nextPutAll: '; ' ].
					  assignments size > 1 ifTrue: [ stream nextPut: $) ] ] ]
]

{ #category : 'private' }
ViennaExecutionTraceAssignmentEvent >> withinModule [

	
]
