Class {
	#name : 'ViennaExecutionTraceEventCSVReader',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'root'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'initialization' }
ViennaExecutionTraceEventCSVReader >> initialize [

	super initialize.
	root := self rootEventClass new
]

{ #category : 'reading' }
ViennaExecutionTraceEventCSVReader >> readLine [

	| line |
	line := self valuesFromLine: (stream upTo: Character cr)
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

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> stream [

	^ stream
]

{ #category : 'accessing' }
ViennaExecutionTraceEventCSVReader >> stream: anObject [

	stream := anObject
]

{ #category : 'private' }
ViennaExecutionTraceEventCSVReader >> valuesFromLine: aString [

	^ Array streamContents: [ :writeStream |
			  | prefix |
			  prefix := ''.
			  (aString substrings: ',') do: [ :str |
					  (str notEmpty and: [ str last = $\ ])
						  ifTrue: [ prefix := prefix , str , ',' ]
						  ifFalse: [
								  writeStream nextPut: prefix , str.
								  prefix := '' ] ].
			  prefix ifNotEmpty: [ writeStream nextPut: prefix allButLast ] ]
]
