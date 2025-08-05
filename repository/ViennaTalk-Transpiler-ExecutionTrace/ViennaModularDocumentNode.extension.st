Extension { #name : 'ViennaModularDocumentNode' }

{ #category : '*ViennaTalk-Transpiler-ExecutionTrace' }
ViennaModularDocumentNode >> openSequenceDiagramFromExpression: aString [

	| script canvas |
	script := MicromaidParser parse:
		          ((self sequenceDiagramSourceFromExpression: aString)
			           ifNil: [ ^ nil ]).
	script isPetit2Failure ifTrue: [ ^ nil ].
	canvas := script roassalBuilder build.
	^ canvas
		  extent: canvas encompassingRectangle extent + (20 @ 20);
		  zoomToFit;
		  @ RSCanvasController;
		  openWithTitle: 'Sequence Diagram of ' , aString
]

{ #category : '*ViennaTalk-Transpiler-ExecutionTrace' }
ViennaModularDocumentNode >> sequenceDiagramFromExpression: aString [

	| script canvas |
	script := MicromaidParser parse:
		          ((self sequenceDiagramSourceFromExpression: aString)
			           ifNil: [ ^ nil ]).
	script isPetit2Failure ifTrue: [ ^ nil ].
	canvas := script roassalBuilder build.
	^ canvas
		  extent: canvas encompassingRectangle extent + (20 @ 20);
		  zoomToFit;
		  asForm
]

{ #category : '*ViennaTalk-Transpiler-ExecutionTrace' }
ViennaModularDocumentNode >> sequenceDiagramSourceFromExpression: aString [

	^ (ViennaTranspilerForExecutionTracing new generate: self)
		  useSequenceDiagramRecorder: aString;
		  evaluateExpression: aString ifError: [ ^ nil ];
		  executionTrace
]
