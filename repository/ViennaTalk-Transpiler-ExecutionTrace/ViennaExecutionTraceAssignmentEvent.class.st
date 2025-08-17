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

{ #category : 'private' }
ViennaExecutionTraceAssignmentEvent >> setModule: aString assignments: anArrayOfAssociation [

	module := aString.
	assignments := anArrayOfAssociation
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
