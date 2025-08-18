Class {
	#name : 'ViennaExecutionTraceEventViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'eventTree',
		'infoMarkdown'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'layout' }
ViennaExecutionTraceEventViewer >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.5;
		  add: eventTree;
		  add: infoMarkdown;
		  yourself
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> expandAll [

	eventTree expandAll
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> format: aString [

	| node |
	node := aString asViennaExpressionAst.
	node isPetit2Success ifTrue: [ ^ node source ].
	node := aString asViennaStatementAst.
	node isPetit2Success ifTrue: [ ^ node source ].
	^ aString
]

{ #category : 'defaults' }
ViennaExecutionTraceEventViewer >> iconFor: aViennaExecutionTraceEvent [

	^ self iconNamed: aViennaExecutionTraceEvent iconName
]

{ #category : 'initialization' }
ViennaExecutionTraceEventViewer >> initializePresenters [

	super initializePresenters.
	eventTree := (self instantiate: SpTreeTablePresenter)
		             addColumn: (SpCompositeTableColumn new
				              title: 'Events';
				              addColumn: (SpImageTableColumn new
						               evaluated: [ :event | self iconFor: event ];
						               width: 20);
				              addColumn: (SpStringTableColumn evaluated: #source);
				              yourself);
		             roots: {  };
		             children: #children;
		             whenSelectedItemChangedDo: [ self selectedEventChanged ];
		             yourself.
	infoMarkdown := (self instantiate: MicrodownPresenter)
		                instVarNamed: #wrapWord put: false;
		                yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> roots [

	^ eventTree roots
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> roots: anArrayOfViennaExecutionTraceRootEvent [

	eventTree roots: anArrayOfViennaExecutionTraceRootEvent
]

{ #category : 'updating' }
ViennaExecutionTraceEventViewer >> selectedEventChanged [

	self updateInfo
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> sequenceDiagramForMicrodownFrom: aViennaExecutionTraceEvent on: aStream [

	| format |
	format := ViennaExecutionTraceSequenceDiagramFormat new
		          root: aViennaExecutionTraceEvent source;
		          yourself.
	aStream
		nextPutAll: '```mermaid';
		cr.
	format writeHeaderOn: aStream.
	aViennaExecutionTraceEvent applyToFormat: format on: aStream.
	format writeFooterOn: aStream.
	aStream
		nextPutAll: '```';
		cr
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> titleLineFor: aViennaExecutionTraceEvent [

	^ aViennaExecutionTraceEvent isRootEvent
		  ifTrue: [
				  String streamContents: [ :stream |
						  stream
							  nextPutAll: '# Execution';
							  cr;
							  nextPutAll: '## source';
							  cr;
							  nextPutAll: '```vdmsl';
							  cr;
							  nextPutAll: (self format: aViennaExecutionTraceEvent source);
							  cr;
							  nextPutAll: '```';
							  cr.
						  stream
							  nextPutAll: '## init';
							  cr.
						  aViennaExecutionTraceEvent initial do: [ :assign |
								  stream
									  nextPutAll: '* ';
									  nextPutAll: assign module;
									  cr.
								  assign assignmentsDo: [ :var :val |
										  stream
											  nextPutAll: '  - ';
											  nextPutAll: var;
											  nextPutAll: ' := ';
											  nextPutAll: val viennaString;
											  cr ] ] ] ]
		  ifFalse: [ '# ' , aViennaExecutionTraceEvent source , String cr ]
]

{ #category : 'updating' }
ViennaExecutionTraceEventViewer >> updateInfo [

	eventTree selectedItem ifNotNil: [ :event |
			infoMarkdown document: (String streamContents: [ :stream |
						 stream nextPutAll: (self titleLineFor: event).
						 stream
							 nextPutAll: '## writes';
							 cr.
						 event globalWrites keysAndValuesDo: [ :module :localWrites |
								 stream
									 nextPutAll: '* ';
									 nextPutAll: module;
									 cr.
								 localWrites keysAndValuesDo: [ :variable :value |
										 stream
											 nextPutAll: '  - ';
											 nextPutAll: variable;
											 nextPutAll: ' := ';
											 nextPutAll: value viennaString;
											 cr ] ].
						 stream
							 nextPutAll: '## Sequence Diagram';
							 cr.
						 self sequenceDiagramForMicrodownFrom: event on: stream ]).
			infoMarkdown withAdapterDo: [ :a |
					a widgetDo: [ :w |
							w
								beNotWrapped;
								hScrollbarShowAlways.
							w textArea extent: w textArea paragraph extent ] ] ]
]
