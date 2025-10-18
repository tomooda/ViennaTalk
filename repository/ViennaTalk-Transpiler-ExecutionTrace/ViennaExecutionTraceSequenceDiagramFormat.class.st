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
		             addLast: '-';
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
ViennaExecutionTraceSequenceDiagramFormat >> writeAssert: aString on: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeCall: aString module: anotherString args: anArray on: aStream [

	| caller callee |
	caller := callStack last.
	callee := anotherString , '`' , aString.
	aliases at: aString ifPresent: [ :name | callee := name ].
	callStack addLast: callee.
	aStream
		nextPutAll: caller;
		nextPutAll: ' ->>+ ';
		nextPutAll: callee;
		nextPutAll: ' : ';
		nextPutAll: callee;
		nextPut: $(.
	anArray
		do: [ :obj | aStream nextPutAll: obj viennaString asHTMLString ]
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
ViennaExecutionTraceSequenceDiagramFormat >> writeReturn: aString module: anotherString value: anObject on: aStream [

	callStack size >= 2 ifTrue: [
			| callee caller |
			callee := callStack removeLast.
			caller := callStack last.
			aStream
				nextPutAll: callee;
				nextPutAll: ' -->>- ';
				nextPutAll: caller;
				nextPutAll: ' : '.
			aStream nextPutAll: anObject viennaString asHTMLString.
			aStream cr ]
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeStateDiffBlock: aDictionary on: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceSequenceDiagramFormat >> writeTimeLabel: aString on: aStream [

	
]
