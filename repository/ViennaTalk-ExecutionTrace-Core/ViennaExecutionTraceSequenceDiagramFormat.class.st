Class {
	#name : 'ViennaExecutionTraceSequenceDiagramFormat',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'aliases',
		'callStack',
		'root'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Formats',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Formats'
}

{ #category : 'initialization' }
ViennaExecutionTraceSequenceDiagramFormat >> initialize [

	callStack := (OrderedCollection new: 128)
		             addLast: '-';
		             yourself.
	aliases := Dictionary new
]

{ #category : 'utilities' }
ViennaExecutionTraceSequenceDiagramFormat >> mermaidEscape: aString [

	| escapes |
	escapes := {
		           ($; -> '#59;').
		           ($( -> '#40;').
		           ($) -> '#41;') } asDictionary.
	^ String streamContents: [ :stream |
		  aString do: [ :char | escapes at: char ifPresent: [ :alt | stream nextPutAll: alt ] ifAbsent: [ stream nextPut: char ] ] ]
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
	caller := self mermaidEscape: callStack last.
	callee := self mermaidEscape: anotherString , '`' , aString.
	aliases at: aString ifPresent: [ :name | callee := name ].
	callStack addLast: callee.
	aStream
		nextPutAll: caller;
		nextPutAll: ' ->>+ ';
		nextPutAll: callee;
		nextPutAll: ' : ';
		nextPutAll: callee;
		nextPut: $(.
	anArray do: [ :obj | aStream nextPutAll: obj viennaString asHTMLString ] separatedBy: [ aStream nextPutAll: ', ' ].
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
			callee := self mermaidEscape: callStack removeLast.
			caller := self mermaidEscape: callStack last.
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
