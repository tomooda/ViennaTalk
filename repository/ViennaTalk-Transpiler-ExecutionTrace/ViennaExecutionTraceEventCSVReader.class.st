Class {
	#name : 'ViennaExecutionTraceEventCSVReader',
	#superclass : 'Object',
	#instVars : [
		'root',
		'inputStream',
		'parser'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'class access' }
ViennaExecutionTraceEventCSVReader >> assignmentEventClass [

	^ ViennaExecutionTraceAssignmentEvent
]

{ #category : 'private' }
ViennaExecutionTraceEventCSVReader >> assignmentSourceToAssoc: aString [

	| index |
	index := aString findString: ':='.
	index = 0 ifTrue: [ ^ self error: 'Expected assignment' ].
	^ (aString copyFrom: 1 to: index - 1) trim
	  -> (parser parse: (aString copyFrom: index + 2 to: aString size))
]

{ #category : 'initialization' }
ViennaExecutionTraceEventCSVReader >> initialize [

	super initialize.
	parser := ViennaVDMValueDecoder current
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

	^ self assignmentEventClass
		  module: anArrayOfString first
		  assignments: (Array streamContents: [ :stream |
					   anArrayOfString allButFirstDo: [ :string |
						   stream nextPut: (self assignmentSourceToAssoc: string) ] ])
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

	^ self operationCallEventClass
		  module: anArrayOfString first
		  operation: anArrayOfString second
		  arguments: ((anArrayOfString allButFirst: 2) collect: [ :string |
				   self sourceToObject: string ])
		  events: (Array streamContents: [ :stream |
					   [
						   | event |
						   event := self readLine.
						   event notNil and: [
								   stream nextPut: event.
								   event class ~= self returnEventClass ] ] whileTrue ])
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readReturnEvent: anArrayOfString [

	^ self returnEventClass
		  module: anArrayOfString first
		  operation: anArrayOfString second
		  returnValue: (self sourceToObject: anArrayOfString third)
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readRootEvent: anArrayOfString [

	^ self rootEventClass
		  initial: (Array streamContents: [ :stream |
					   | assignments |
					   assignments := OrderedCollection new.
					   anArrayOfString do: [ :string |
							   (string includes: $:)
								   ifTrue: [ assignments addLast: string ]
								   ifFalse: [
										   assignments ifNotEmpty: [
											   stream nextPut: (self readAssignmentEvent: assignments) ].
										   assignments
											   removeAll;
											   addLast: string ] ].
					   assignments size >= 2 ifTrue: [
						   stream nextPut: (self readAssignmentEvent: assignments) ] ])
		  events: (Array streamContents: [ :stream |
					   | event |
					   [
						   event := self readLine.
						   event notNil ] whileTrue: [ stream nextPut: event ] ])
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
ViennaExecutionTraceEventCSVReader >> sourceToObject: aString [

	| object |
	object := parser parse: aString trim.
	object isPetit2Failure ifTrue: [ ^ Object new ].
	^ object
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
