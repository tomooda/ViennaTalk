Class {
	#name : #ViennaVDMDebugger,
	#superclass : #StDebugger,
	#instVars : [
		'specification'
	],
	#category : #'ViennaTalk-Transpiler-Debugger'
}

{ #category : #commands }
ViennaVDMDebugger class >> buildCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup [

	StDebuggerStackCommandTreeBuilder
		buildCommandsGroupWith: stDebuggerInstance
		forRoot: rootCommandGroup.
	ViennaDebuggerToolbarCommandTreeBuilder
		buildCommandsGroupWith: stDebuggerInstance
		forRoot: rootCommandGroup.
	StDebuggerCodeCommandTreeBuilder
		buildCommandsGroupWith: stDebuggerInstance
		forRoot: rootCommandGroup.
	StDebuggerConfigurationCommandTreeBuilder
		buildCommandsGroupWith: stDebuggerInstance
		forRoot: rootCommandGroup
]

{ #category : #commands }
ViennaVDMDebugger class >> buildSindarinExtentionCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup [

	<extensionCommands>
	| commands codeGroup toolbarGroup toolbarSindarinGroup |
	commands := (Pragma allNamed: #codeExtensionDebugCommand:) collect: [ 
		            :prg | 
		            | class |
		            class := prg methodClass soleInstance.
		            class forSpecContext: stDebuggerInstance ].


	codeGroup := rootCommandGroup
	             / StDebuggerCodeCommandTreeBuilder groupName
	             / StDebuggerCodeCommandTreeBuilder new codeDebugCommandsGroupName.
	commands do: [ :c | codeGroup register: c ].

	toolbarGroup := rootCommandGroup / ViennaDebuggerToolbarCommandTreeBuilder groupName.
	toolbarSindarinGroup := CmCommandGroup forSpec
			beToolbarPopoverButton;
			name: 'Advanced Step';
			icon: (stDebuggerInstance application iconNamed: #smallExpert);
			yourself.
	toolbarGroup register: toolbarSindarinGroup.
	commands do: [ :c | toolbarSindarinGroup register: c ].		 
]

{ #category : #testing }
ViennaVDMDebugger class >> debugSession: aDebugSession [

	^ super debugSession: aDebugSession asViennaDebugSession
]

{ #category : #accessing }
ViennaVDMDebugger class >> defaultDebuggerRank [ 
	^ 10
]

{ #category : #accessing }
ViennaVDMDebugger class >> defaultTitle [

	^ 'VDM'
]

{ #category : #testing }
ViennaVDMDebugger class >> handlesDebugSession: aDebugSession [

	^ aDebugSession context specificationContext notNil
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> acceptSpecificationChanges: newSpecification forContext: aContext [

	"do nothing for now"

	
]

{ #category : #'commands - support' }
ViennaVDMDebugger >> buildContextMenus [
	| stackGroup codeCommands debuggerCommandGroup |
	
	debuggerCommandGroup := self rootCommandsGroup.
	"Stack"
	stackGroup := debuggerCommandGroup / StDebuggerStackCommandTreeBuilder groupName. 
	stackTable contextMenu: stackGroup beRoot asMenuPresenter.
	stackTable contextKeyBindings: (self keybindsForFromContextMenu: stackGroup).
	 
	"Toolbar"
	toolbarCommandGroup := debuggerCommandGroup / ViennaDebuggerToolbarCommandTreeBuilder groupName.
	SpToolbarPresenterBuilder new
		toolbarPresenter: toolbar;
		visit: toolbarCommandGroup.

	"Code"
	codeCommands := debuggerCommandGroup / StDebuggerCodeCommandTreeBuilder groupName.
	code contextMenu: codeCommands beRoot asMenuPresenter.
	
	"Configuration"
	stackHeader toolbarActions: (debuggerCommandGroup / StDebuggerConfigurationCommandTreeBuilder groupName).
]

{ #category : #'updating - widgets' }
ViennaVDMDebugger >> clearSpecification [

	self specification
		clearSelection;
		clearContent
]

{ #category : #specs }
ViennaVDMDebugger >> codeLayout [

	^ SpBoxLayout newTopToBottom
		  add: #toolbar expand: false;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 60 percent;
				   add: #code;
				   add: #specification;
				   yourself);
		  yourself
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> currentSpecification [
	^ self currentContext specification
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> discardSpecificationChangesFor: aContext [

	self specification text: aContext specification highlightedSource.
	self update
]

{ #category : #initialization }
ViennaVDMDebugger >> initializePresenters [

	super initializePresenters.
	self initializeSpecification.

]

{ #category : #initialization }
ViennaVDMDebugger >> initializeShortcuts: aWindowPresenter [

	super initializeShortcuts: aWindowPresenter.
	aWindowPresenter
		bindKeyCombination: ViennaStepIntoCommand defaultShortcut
		toAction: [ self vdmStepInto ].
	aWindowPresenter
		bindKeyCombination: ViennaStepOverCommand defaultShortcut
		toAction: [ self vdmStepOver ]
]

{ #category : #initialization }
ViennaVDMDebugger >> initializeSpecification [

	specification := self newText.
	specification whenSubmitDo: [ :text | 
		self acceptSpecificationChanges: text string forContext: self selectedContext ].
	specification whenResetDo: [ self discardSpecificationChangesFor: self selectedContext ]
]

{ #category : #initialization }
ViennaVDMDebugger >> initializeStack [

	super initializeStack.
	stackTable transmitDo: [ :context | 
		stackTable selection isEmpty ifFalse: [ 
			self updateSpecificationFromContext: context ] ]
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> newTitle [

	^ '[Vienna]', super newTitle
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> selectedSpecification [

	^ self selectedContext ifNotNil: #specification
]

{ #category : #'accessing - widgets' }
ViennaVDMDebugger >> specification [

	^ specification
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> updateSpecificationFor: aContext [

	self specification text: (aContext specification
			 ifNil: [ Text new ]
			 ifNotNil: [ :spec | spec highlightedSource ])
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> updateSpecificationFromContext: aContext [

	| selectionInterval |
	aContext ifNil: [ ^ self clearSpecification ].

	selectionInterval := self session selectedVDMRangeForContext:
		                     aContext.
	self updateSpecificationFor: aContext.
	self specification
		selectionInterval:
			(selectionInterval last to: selectionInterval last - 1).
	self
		updateSpecificationTextSegmentDecoratorsIn: aContext
		forInterval: selectionInterval
]

{ #category : #'updating - widgets' }
ViennaVDMDebugger >> updateSpecificationTextSegmentDecoratorsIn: aContext forInterval: selectionInterval [

	self specification
		removeAllTextSegmentDecorations;
		addTextSegmentDecoration: (SpTextPresenterDecorator new
				 highlightColor: (Color orange alpha: 0.5);
				 underlineColor: (Color white alpha: 0);
				 interval:
					 (selectionInterval first to: selectionInterval last + 1);
				 yourself)
]

{ #category : #action }
ViennaVDMDebugger >> vdmStepInto [

	self session vdmStepInto: self context
]

{ #category : #action }
ViennaVDMDebugger >> vdmStepOver [

	self session vdmStepOver: self context
]
