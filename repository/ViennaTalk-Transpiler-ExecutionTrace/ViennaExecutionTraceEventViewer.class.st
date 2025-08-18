Class {
	#name : 'ViennaExecutionTraceEventViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'eventTree',
		'infoMarkdown',
		'expandButton',
		'stepForwardButton',
		'stepBackwardButton',
		'diveIntoButton',
		'soarUpButton',
		'collapseButton'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> collapse [

	| path |
	path := eventTree selection selectedPath.
	eventTree collapseAll.
	eventTree selectPath: path
]

{ #category : 'layout' }
ViennaExecutionTraceEventViewer >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.5;
		  add: (SpBoxLayout newVertical
				   add: eventTree expand: true;
				   add: (SpBoxLayout newHorizontal
						    add: stepForwardButton;
						    add: stepBackwardButton;
						    add: diveIntoButton;
						    add: soarUpButton;
						    add: ' ' asPresenter expand: false;
						    add: expandButton;
						    add: collapseButton;
						    yourself)
				   expand: false;
				   yourself);
		  add: infoMarkdown;
		  yourself
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> diveInto [

	eventTree selection selectedPath ifNotEmpty: [ :path |
		eventTree selectPath: (path copyWith: 1) ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> expand [

	eventTree selection selectedPath
		ifNotEmpty: [ :path |
				eventTree withAdapterDo: [ :a |
						a widgetDo: [ :w |
								(w dataSource itemAtPath: path) expandAll.
								w dataSource tableRefresh ] ].
				eventTree selectPath: path ]
		ifEmpty: [ eventTree expandAll ]
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
		                yourself.
	expandButton := self newButton
		                icon: (self iconNamed: #dropDown);
		                label: 'expand';
		                action: [ self expand ];
		                yourself.
	collapseButton := self newButton
		                  icon: ((self iconNamed: #dropDown) rotateBy: 270);
		                  label: 'collapse';
		                  action: [ self collapse ];
		                  yourself.
	stepForwardButton := self newButton
		                     icon: (self iconNamed: #down);
		                     label: 'step';
		                     action: [ self stepForward ];
		                     disable;
		                     yourself.
	stepBackwardButton := self newButton
		                      icon: (self iconNamed: #up);
		                      label: 'back';
		                      action: [ self stepBackward ];
		                      disable;
		                      yourself.
	diveIntoButton := self newButton
		                  icon: (self iconNamed: #right);
		                  label: 'dive';
		                  action: [ self diveInto ];
		                  disable;
		                  yourself.
	soarUpButton := self newButton
		                icon: (self iconNamed: #left);
		                label: 'caller';
		                action: [ self soarUp ];
		                disable;
		                yourself
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> nextPath: anArrayOfInteger [

	| path |
	path := anArrayOfInteger copy.
	[
		path ifEmpty: [ ^ path ].
		path at: path size put: path last + 1.
		(eventTree itemAtPath: path ifAbsent: [ nil ]) ifNotNil: [ ^ path ].
		path := path allButLast ] repeat
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> prevPath: anArrayOfInteger [

	| path |
	path := anArrayOfInteger copy.
	[ path notEmpty and: [ path last = 1 ] ] whileTrue: [
		path := path allButLast ].
	path ifNotEmpty: [ path at: path size put: path last - 1 ].
	^ path
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> roots [

	^ eventTree roots
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> roots: anArrayOfViennaExecutionTraceRootEvent [

	eventTree roots: anArrayOfViennaExecutionTraceRootEvent.
	anArrayOfViennaExecutionTraceRootEvent ifNotEmpty: [
		eventTree selectPath: #( 1 ) ]
]

{ #category : 'updating' }
ViennaExecutionTraceEventViewer >> selectedEventChanged [

	self updateInfo.
	self updateButtons
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> sequenceDiagramForMicrodownFrom: aViennaExecutionTraceEvent on: aStream [

	| format |
	format := ViennaExecutionTraceSequenceDiagramFormat new
		          root: aViennaExecutionTraceEvent source;
		          yourself.
	aStream
		nextPutAll: '## sequence diagram';
		cr.
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

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> soarUp [

	eventTree selection selectedPath ifNotEmpty: [ :path |
		eventTree selectPath: path allButLast ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> stepBackward [

	(self prevPath: eventTree selection selectedPath) ifNotEmpty: [ :path |
		eventTree selectPath: path ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> stepForward [

	(self nextPath: eventTree selection selectedPath) ifNotEmpty: [ :path |
		eventTree selectPath: path ]
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
ViennaExecutionTraceEventViewer >> updateButtons [

	| path selection children |
	path := eventTree selection selectedPath.
	selection := eventTree itemAtPath: path ifAbsent: [ nil ].
	children := selection
		            ifNotNil: [ selection children ]
		            ifNil: [ #(  ) ].
	expandButton enabled: children notEmpty.
	collapseButton enable.
	stepForwardButton enabled: (self nextPath: path) notEmpty.
	stepBackwardButton enabled: (self prevPath: path) notEmpty.
	diveIntoButton enabled: (path notEmpty and: [
			 (eventTree itemAtPath: (path copyWith: 1) ifAbsent: [ nil ])
				 notNil ]).
	soarUpButton enabled: path size >= 2
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
						 self sequenceDiagramForMicrodownFrom: event on: stream ]).
			infoMarkdown withAdapterDo: [ :a |
					a widgetDo: [ :w |
							w
								beNotWrapped;
								hScrollbarShowAlways.
							w textArea extent: w textArea paragraph extent ] ] ]
]
