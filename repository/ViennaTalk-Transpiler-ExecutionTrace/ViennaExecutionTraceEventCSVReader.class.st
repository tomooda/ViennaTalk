Class {
	#name : 'ViennaExecutionTraceEventCSVReader',
	#superclass : 'Object',
	#instVars : [
		'root',
		'inputStream'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'class access' }
ViennaExecutionTraceEventCSVReader >> assignmentEventClass [

	^ ViennaExecutionTraceAssignmentEvent
]

{ #category : 'initialization' }
ViennaExecutionTraceEventCSVReader >> initialize [

	super initialize.
	root := self rootEventClass new
]

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> inputStream [

	^ inputStream
]

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> inputStream: anObject [

	inputStream := anObject
]

{ #category : 'class access' }
ViennaExecutionTraceEventCSVReader >> operationCallEventClass [

	^ ViennaExecutionTraceOperationCallEvent
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readAssignmentEvent: anArrayOfString [

	^ self assignmentEventClass new
		  module: anArrayOfString first;
		  assignments: anArrayOfString allButFirst
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readLine [

	| line |
	inputStream atEnd ifTrue: [ ^ nil ].
	line := self valuesFromLine: (inputStream upTo: Character cr).
	line ifEmpty: [ ^ nil ].
	line first = 'i' ifTrue: [ ^ self readRootEvent: line allButFirst ].
	line first = 'a' ifTrue: [
		^ self readAssignmentEvent: line allButFirst ].
	line first = 'c' ifTrue: [
		^ self readOperationCallEvent: line allButFirst ].
	line first = 'r' ifTrue: [ ^ self readReturnEvent: line allButFirst ]
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readOperationCallEvent: anArrayOfString [

	^ self operationCallEventClass new
		  module: anArrayOfString first;
		  operation: anArrayOfString second;
		  arguments: (anArrayOfString allButFirst: 2);
		  events: (Array streamContents: [ :stream |
						   [
							   | event |
							   event := self readLine.
							   event notNil ifTrue: [ stream nextPut: event ].
							   event notNil and: [ event class ~= self returnEventClass ] ]
							   whileTrue ]);
		  yourself
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readReturnEvent: anArrayOfString [

	^ self returnEventClass new
		  module: anArrayOfString first;
		  operation: anArrayOfString second;
		  returnValue: anArrayOfString third;
		  yourself
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readRootEvent: anArrayOfString [

	root
		initialAssignmentEvents: (Array streamContents: [ :stream |
						 | module assignments |
						 module := nil.
						 assignments := OrderedCollection new.
						 anArrayOfString do: [ :string |
									 (string includes: $:)
										 ifTrue: [ assignments addLast: string ]
										 ifFalse: [
												 module ifNotNil: [
															 stream nextPut: (self assignmentEventClass new
																		  module: module;
																		  assignments: assignments asArray) ].
												 module := string.
												 assignments removeAll ] ].
						 module ifNotNil: [
								 stream nextPut: (self assignmentEventClass new
										  module: module;
										  assignments: assignments asArray) ] ]);
		events: (Array streamContents: [ :stream |
					 | event |
					 [
						 event := self readLine.
						 event notNil ] whileTrue: [ stream nextPut: event ] ]).
	^ root
]

{ #category : 'class access' }
ViennaExecutionTraceEventCSVReader >> returnEventClass [

	^ ViennaExecutionTraceReturnEvent
]

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> root [

	^ root
]

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> root: anObject [

	root := anObject
]

{ #category : 'class access' }
ViennaExecutionTraceEventCSVReader >> rootEventClass [

	^ ViennaExecutionTraceRootEvent
]

{ #category : 'private' }
ViennaExecutionTraceEventCSVReader >> unescape: aString [

	^ String streamContents: [ :writeStream |
			  aString readStreamDo: [ :readStream |
					  [ readStream atEnd ] whileFalse: [
							  | char |
							  ((char := readStream next) = $\ and: [ readStream atEnd not ])
								  ifTrue: [ char := readStream next ].
							  writeStream nextPut: char ] ] ]
]

{ #category : 'private' }
ViennaExecutionTraceEventCSVReader >> valuesFromLine: aString [

	^ Array streamContents: [ :stream |
			  | prefix |
			  prefix := ''.
			  (aString substrings: ',') do: [ :str |
					  (str notEmpty and: [ str last = $\ ])
						  ifTrue: [ prefix := prefix , str , ',' ]
						  ifFalse: [
								  stream nextPut: (self unescape: prefix , str) trim.
								  prefix := '' ] ].
			  prefix ifNotEmpty: [
				  stream nextPut: (self unescape: prefix allButLast) trim ] ]
]
