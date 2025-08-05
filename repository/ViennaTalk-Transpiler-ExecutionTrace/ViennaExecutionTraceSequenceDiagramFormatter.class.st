Class {
	#name : 'ViennaExecutionTraceSequenceDiagramFormatter',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'aliases',
		'callStack',
		'root'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Formats',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Formats'
}

{ #category : 'initialization' }
ViennaExecutionTraceSequenceDiagramFormatter >> initialize [

	callStack := (OrderedCollection new: 128)
		             addLast: '_';
		             yourself.
	aliases := Dictionary new
]

{ #category : 'accessing' }
ViennaExecutionTraceSequenceDiagramFormatter >> root [

	^ root
]

{ #category : 'accessing' }
ViennaExecutionTraceSequenceDiagramFormatter >> root: aString [

	root := aString.
	callStack := (OrderedCollection new: 128)
		             addLast: aString;
		             yourself
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormatter >> writeCall: aString args: anArray on: aStream [

	| caller callee |
	caller := callStack last.
	callee := aliases at: aString ifAbsent: [ aString ].
	callStack addLast: callee.
	aStream
		nextPutAll: caller;
		nextPutAll: ' ->>+ ';
		nextPutAll: callee;
		nextPutAll: ' : ';
		nextPutAll: aString;
		nextPut: $(.
	anArray
		do: [ :obj | obj viennaStringOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream
		nextPutAll: ')';
		cr
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormatter >> writeFooterOn: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormatter >> writeHeaderOn: aStream [

	aStream
		nextPutAll: 'sequenceDiagram';
		cr
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormatter >> writeReturn: aString value: anObject on: aStream [

	| callee caller |
	callee := callStack removeLast.
	caller := callStack last.
	aStream
		nextPutAll: callee;
		nextPutAll: ' -->>- ';
		nextPutAll: caller;
		nextPutAll: ' : '.
	anObject viennaStringOn: aStream.
	aStream cr
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormatter >> writeState: aDictionary on: outputStream [

	
]
