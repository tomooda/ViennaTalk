Class {
	#name : 'ViennaExecutionTraceEventViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'eventTree'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'layout' }
ViennaExecutionTraceEventViewer >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: eventTree expand: true;
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
