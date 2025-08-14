Class {
	#name : 'ViennaExecutionTraceSequenceDiagramFormat',
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
ViennaExecutionTraceSequenceDiagramFormat >> initialize [

	callStack := (OrderedCollection new: 128)
		             addLast: '_';
		             yourself.
	aliases := Dictionary new
]

{ #category : 'user interface' }
ViennaExecutionTraceSequenceDiagramFormat >> open: aViennaExecutionTraceRecorder withTitle: aString [

	^ aViennaExecutionTraceRecorder output openMicromaidWithTitle:
		  aString
]

{ #category : 'accessing' }
ViennaExecutionTraceSequenceDiagramFormat >> root [

	^ root
]

{ #category : 'accessing' }
ViennaExecutionTraceSequenceDiagramFormat >> root: aString [

	root := aString copyReplaceAll: String cr with: String space.
	callStack := (OrderedCollection new: 128)
		             addLast: root;
		             yourself
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeCall: aString args: anArray on: aStream [

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
ViennaExecutionTraceSequenceDiagramFormat >> writeFooterOn: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeHeaderOn: aStream [

	aStream
		nextPutAll: 'sequenceDiagram';
		cr
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeReturn: aString value: anObject on: aStream [

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
ViennaExecutionTraceSequenceDiagramFormat >> writeStateDiffBlock: aDictionary on: aStream [

	
]
