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

{ #category : 'updating' }
ViennaExecutionTraceEventViewer >> updateInfo [

	eventTree selectedItem ifNotNil: [ :event |
			infoMarkdown document: (String streamContents: [ :stream |
						 stream
							 nextPutAll: '# writes';
							 cr.
						 event globalWrites keysAndValuesDo: [ :module :localWrites |
								 stream
									 nextPutAll: '### ';
									 nextPutAll: module;
									 cr.
								 localWrites keysAndValuesDo: [ :variable :value |
										 stream
											 nextPutAll: '* ';
											 nextPutAll: variable;
											 nextPutAll: ' := ';
											 nextPutAll: value viennaString;
											 cr ] ] ]) ]
]
