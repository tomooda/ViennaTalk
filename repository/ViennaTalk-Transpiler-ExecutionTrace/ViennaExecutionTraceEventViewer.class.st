Class {
	#name : 'ViennaExecutionTraceEventViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'specification',
		'transpiledSpecification',
		'probeSources',
		'probes',
		'eventTree',
		'expandButton',
		'stepForwardButton',
		'stepBackwardButton',
		'diveIntoButton',
		'soarUpButton',
		'collapseButton',
		'infoMarkdown',
		'infoSettingsButton',
		'openSequenceDiagramButton',
		'openStateDiagramButton',
		'exportButton',
		'isGlobalScope',
		'showsAggregatedAssignments',
		'showsSequenceDiagram',
		'showsStateDiagram',
		'showsProbeNamesInStateDiagram',
		'showsOperationNamesInStateDiagram',
		'openStateDiagramExtButton'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Spec2',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Spec2'
}

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> aggregatedAssignmentsFrom: aViennaExecutionTraceEvent on: aStream [

	aStream
		nextPutAll: '## writes';
		cr;
		cr.
	aViennaExecutionTraceEvent globalWrites keysAndValuesDo: [
			:module
			:localWrites |
			aStream
				nextPutAll: '* ';
				nextPutAll: module;
				cr.
			localWrites keysAndValuesDo: [ :variable :value |
					aStream
						nextPutAll: '  - ';
						nextPutAll: variable;
						nextPutAll: ' := ';
						nextPutAll: value viennaString;
						cr ] ].
	aStream cr
]

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
		  positionOfSlider: 0.3;
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
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: infoSettingsButton;
						    add: openSequenceDiagramButton;
						    add: openStateDiagramButton;
						    add: openStateDiagramExtButton
						    width: self class buttonHeight;
						    add: '    ' expand: false;
						    add: exportButton;
						    yourself)
				   expand: false;
				   add: infoMarkdown expand: true;
				   yourself);
		  yourself
]

{ #category : 'defaults' }
ViennaExecutionTraceEventViewer >> defaultProbes [

	^ Array streamContents: [ :stream |
			  (specification notNil and: [ transpiledSpecification notNil ])
				  ifNotNil: [
						  specification modulesDo: [ :module |
								  | transpiledModule |
								  transpiledModule := transpiledSpecification at:
									                      module identifier.
								  module stateDefinition ifNotNil: [ :stateDefinition |
										  stateDefinition fieldsDo: [ :field |
												  | identifier |
												  identifier := field identifier.
												  (ViennaAbstractStateProbe
													   name: identifier
													   receiver: transpiledModule
													   source: identifier) ifCompiledDo: [ :probe |
													  stream nextPut: probe ] ] ] ] ] ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> diveInto [

	eventTree selection selectedPath ifNotEmpty: [ :path |
		eventTree selectPath: (path copyWith: 1) ]
]

{ #category : 'private' }
ViennaExecutionTraceEventViewer >> dryRunUntil: aViennaExecutionTraceEvent [

	self roots do: [ :root |
			root isRootEvent ifTrue: [
					root initial do: [ :event |
						event applyAssignmentTo: transpiledSpecification ] ].
			root allEventsDo: [ :event |
					event == aViennaExecutionTraceEvent ifTrue: [ ^ self ].
					event applyAssignmentTo: transpiledSpecification ] ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> editProbes [

	| probeBrowser |
	probeBrowser := ViennaStateProbeBrowser new
		                specification: specification;
		                abstractStateProbes: probes;
		                yourself.
	probeBrowser asModalWindow
		okAction: [
				probes := probeBrowser probesWithTranspiledSpecification:
						          transpiledSpecification ];
		open
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

{ #category : 'menus' }
ViennaExecutionTraceEventViewer >> exportMenu [

	^ self newMenu
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'CSV file';
								  action: [ self saveCSV ] ];
					  addItem: [ :item |
							  item
								  name: 'Mermaid sequence diagram file';
								  action: [ self saveSequenceDiagram ] ];
					  addItem: [ :item |
							  item
								  name: 'Mermaid state diagram file';
								  action: [ self saveStateDiagram ] ];
					  yourself ];
		  yourself
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

{ #category : 'menus' }
ViennaExecutionTraceEventViewer >> infoSettingsMenu [

	^ self newMenu
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'Global scope';
								  state: isGlobalScope;
								  action: [
										  isGlobalScope := true.
										  self updateInfo ] ];
					  addItem: [ :item |
							  item
								  name: 'Module scope';
								  state: isGlobalScope not;
								  action: [
										  isGlobalScope := false.
										  self updateInfo ] ] ];
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: '	shows aggregated assignments';
								  state: showsAggregatedAssignments;
								  action: [
										  showsAggregatedAssignments := true.
										  self updateInfo ] ];
					  addItem: [ :item |
							  item
								  name: 'shows no assignments';
								  state: showsAggregatedAssignments not;
								  action: [
										  showsAggregatedAssignments := false.
										  self updateInfo ] ] ];
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'shows Sequence Diagram';
								  state: showsSequenceDiagram;
								  action: [
										  showsSequenceDiagram := showsSequenceDiagram not.
										  self updateInfo ] ];
					  addItem: [ :item |
							  item
								  name: 'shows Abstract State Diagram';
								  state: showsStateDiagram;
								  action: [
										  showsStateDiagram := showsStateDiagram not.
										  self updateInfo ] ] ];
		  yourself
]

{ #category : 'initialization' }
ViennaExecutionTraceEventViewer >> initialize [

	super initialize.
	isGlobalScope := true.
	showsAggregatedAssignments := true.
	showsSequenceDiagram := false.
	showsStateDiagram := false.
	showsProbeNamesInStateDiagram := false.
	showsOperationNamesInStateDiagram := false
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
		                yourself.
	infoMarkdown := (self instantiate: MicrodownPresenter)
		                instVarNamed: #wrapWord put: false;
		                yourself.
	infoSettingsButton := self newButton
		                      icon: (self iconNamed: #configuration);
		                      label: 'Info settings...';
		                      action: [
			                      self infoSettingsMenu openWithSpecAtPointer ];
		                      yourself.
	openSequenceDiagramButton := self newButton
		                             icon: (self iconNamed: #window);
		                             label: 'Sequence Diagram';
		                             action: [ self openSequenceDiagram ];
		                             yourself.
	openStateDiagramButton := self newButton
		                          icon: (self iconNamed: #window);
		                          label: 'State Diagram';
		                          action: [ self openStateDiagram ];
		                          yourself.
	openStateDiagramExtButton := self newButton
		                             icon: (self iconNamed: #dropDown);
		                             action: [
			                             self stateDiagramMenu
				                             openWithSpecAtPointer ];
		                             yourself.
	exportButton := self newButton
		                icon: (self iconNamed: #smallExport);
		                label: 'Export...';
		                action: [ self exportMenu openWithSpecAtPointer ];
		                yourself
]

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> micromaidSequenceDiagramFrom: aViennaExecutionTraceEvent on: aStream [

	| format |
	format := ViennaExecutionTraceSequenceDiagramFormat new
		          root: 'caller';
		          yourself.
	format writeHeaderOn: aStream.
	aViennaExecutionTraceEvent applyToFormat: format on: aStream.
	format writeFooterOn: aStream
]

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> micromaidStateDiagramFrom: aViennaExecutionTraceEvent on: aStream [

	| format |
	format := ViennaExecutionTraceStateDiagramFormat new
		          probes: self probes;
		          showsProbeNames: showsProbeNamesInStateDiagram;
		          yourself.
	self dryRunUntil: aViennaExecutionTraceEvent.
	format writeHeaderOn: aStream.
	aViennaExecutionTraceEvent
		applyToFormat: format
		on: aStream
		before: [ :event | event applyAssignmentTo: transpiledSpecification ]
		after: [ :event |  ].
	format writeFooterOn: aStream
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

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> openSequenceDiagram [

	eventTree selectedItem ifNotNil: [ :event |
			(String streamContents: [ :stream |
				 self micromaidSequenceDiagramFrom: event on: stream ])
				openMicromaidWithTitle: 'Sequence Diagram from ' , event source ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> openStateDiagram [

	eventTree selectedItem ifNotNil: [ :event |
			(String streamContents: [ :stream |
				 self micromaidStateDiagramFrom: event on: stream ])
				openMicromaidBuilderWith: [ :builder | builder gap: 120 ]
				title: 'Abstract State Diagram from ' , event source ]
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
ViennaExecutionTraceEventViewer >> probes [

	^ probes ifNil: [ probes := self defaultProbes ]
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

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> saveCSV [

	^ self inform: 'Not implemented yet'
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> saveSequenceDiagram [

	eventTree selectedItem ifNotNil: [ :event |
			(self confirm:
				 'Copy mermaid source for sequence diagram to the copy buffer?')
				ifTrue: [
						Clipboard clipboardText: (String streamContents: [ :stream |
								 self micromaidSequenceDiagramFrom: event on: stream ]) ] ]
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> saveStateDiagram [

	eventTree selectedItem ifNotNil: [ :event |
			(self confirm:
				 'Copy mermaid source for abstract state diagram to the copy buffer?')
				ifTrue: [
						Clipboard clipboardText: (String streamContents: [ :stream |
								 self micromaidStateDiagramFrom: event on: stream ]) ] ]
]

{ #category : 'updating' }
ViennaExecutionTraceEventViewer >> selectedEventChanged [

	self updateInfo.
	self updateButtons
]

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> sequenceDiagramForMicrodownFrom: aViennaExecutionTraceEvent on: aStream [

	aStream
		nextPutAll: '## sequence diagram';
		cr.
	aStream
		nextPutAll: '```mermaid';
		cr.
	self
		micromaidSequenceDiagramFrom: aViennaExecutionTraceEvent
		on: aStream.
	aStream
		nextPutAll: '```';
		cr
]

{ #category : 'operations' }
ViennaExecutionTraceEventViewer >> soarUp [

	eventTree selection selectedPath ifNotEmpty: [ :path |
		eventTree selectPath: path allButLast ]
]

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> sourceFrom: aViennaExecutionTraceEvent on: aStream [

	aViennaExecutionTraceEvent isOperationCallEvent ifTrue: [
			(self
				 sourceOfOperation: aViennaExecutionTraceEvent operation
				 module: aViennaExecutionTraceEvent module) ifNotNil: [ :source |
					aStream
						nextPutAll: '## source';
						cr;
						cr;
						nextPutAll: '```vdmsl';
						cr;
						nextPutAll: source;
						cr;
						nextPutAll: '```';
						cr;
						cr ] ].
	aViennaExecutionTraceEvent isRootEvent ifTrue: [
			aStream
				nextPutAll: '## source';
				cr;
				cr;
				nextPutAll: '```vdmsl';
				cr;
				nextPutAll: (self format: aViennaExecutionTraceEvent source);
				cr;
				nextPutAll: '```';
				cr;
				cr ]
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> sourceOfOperation: aString module: anotherString [

	^ specification ifNotNil: [
			  ((specification moduleNamed: anotherString) ifNotNil: [ :module |
				   module resolveIdentifier: aString ]) ifNotNil: #source ]
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> specification [

	^ specification
]

{ #category : 'accessing' }
ViennaExecutionTraceEventViewer >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode.
	transpiledSpecification := specification ifNotNil: [
			                           ViennaVDM2SmalltalkObject new
				                           disableRuntimeCheck;
				                           generate: specification ].
	probes := self defaultProbes
]

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> stateDiagramForMicrodownFrom: aViennaExecutionTraceEvent on: aStream [

	aStream
		nextPutAll: '## abstract state diagram';
		cr.
	aStream
		nextPutAll: '```mermaid';
		cr.
	self
		micromaidStateDiagramFrom: aViennaExecutionTraceEvent
		on: aStream.
	aStream
		nextPutAll: '```';
		cr
]

{ #category : 'menus' }
ViennaExecutionTraceEventViewer >> stateDiagramMenu [

	^ self newMenu
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'Show probe names';
								  state: showsProbeNamesInStateDiagram;
								  action: [
									  showsProbeNamesInStateDiagram := showsProbeNamesInStateDiagram
										                                   not ] ];
					  addItem: [ :item |
							  item
								  name: 'Show operation names';
								  state: showsOperationNamesInStateDiagram;
								  action: [
										  showsOperationNamesInStateDiagram := showsOperationNamesInStateDiagram
											                                       not ] ] ];
		  addGroup: [ :group |
				  group addItem: [ :item |
						  item
							  name: 'Edit abstract state probes...';
							  action: [ self editProbes ] ] ];
		  yourself
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

{ #category : 'generating' }
ViennaExecutionTraceEventViewer >> titleLineFor: aViennaExecutionTraceEvent on: aStream [

	aViennaExecutionTraceEvent isRootEvent
		ifTrue: [
				aStream
					nextPutAll: '# Execution';
					cr;
					cr;
					nextPutAll: '## init';
					cr;
					cr.
				aViennaExecutionTraceEvent initial do: [ :assign |
						aStream
							nextPutAll: '* ';
							nextPutAll: assign module;
							cr.
						assign assignmentsDo: [ :var :val |
								aStream
									nextPutAll: '  - ';
									nextPutAll: var;
									nextPutAll: ' := ';
									nextPutAll: val viennaString;
									cr ] ].
				aStream cr ]
		ifFalse: [
				aStream
					nextPutAll: '# ';
					nextPutAll: aViennaExecutionTraceEvent source;
					cr;
					cr ]
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

	| event |
	event := eventTree selectedItem ifNil: [ ^ self ].
	isGlobalScope ifFalse: [ event := event copyWithinModule ].
	infoMarkdown document: (String streamContents: [ :stream |
				 self titleLineFor: event on: stream.
				 self sourceFrom: event on: stream.
				 showsAggregatedAssignments ifTrue: [
					 self aggregatedAssignmentsFrom: event on: stream ].
				 showsSequenceDiagram ifTrue: [
					 self sequenceDiagramForMicrodownFrom: event on: stream ].
				 showsStateDiagram ifTrue: [
					 self stateDiagramForMicrodownFrom: event on: stream ] ]).
	infoMarkdown withAdapterDo: [ :a |
			a widgetDo: [ :w |
					w
						beNotWrapped;
						hScrollbarShowAlways.
					w textArea extent: w textArea paragraph extent ] ]
]
