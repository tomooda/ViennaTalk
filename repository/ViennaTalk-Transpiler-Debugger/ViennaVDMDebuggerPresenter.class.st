Class {
	#name : 'ViennaVDMDebuggerPresenter',
	#superclass : 'StPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'vdmSource',
		'toolbar',
		'sliceNodes',
		'tracingSource',
		'sliceAttribute'
	],
	#category : 'ViennaTalk-Transpiler-Debugger',
	#package : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : 'debugger extension' }
ViennaVDMDebuggerPresenter class >> defaultDisplayOrder [

	^ 1
]

{ #category : 'layout' }
ViennaVDMDebuggerPresenter class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #toolbar expand: false fill: false padding: 0;
		add: #vdmSource;
		yourself
]

{ #category : 'debugger extension' }
ViennaVDMDebuggerPresenter class >> showInDebugger [

	^ showDebuggerExtension ifNil: [ showDebuggerExtension := true ]
]

{ #category : 'visiting' }
ViennaVDMDebuggerPresenter >> accept: aVisitor [

	^ aVisitor visitVDM: self
]

{ #category : 'slicing' }
ViennaVDMDebuggerPresenter >> clearSlice [

	self sliceNodes: Array new
]

{ #category : 'debugger extension' }
ViennaVDMDebuggerPresenter >> debuggerExtensionToolName [

	^ 'VDM'
]

{ #category : 'slicing' }
ViennaVDMDebuggerPresenter >> extractSliceOf: aViennaNode [

	(aViennaNode
		 detectParent: #isViennaOperationDefinitionNode
		 ifNone: [ nil ]) ifNotNil: [ :operation |
		| slicer |
		slicer := ViennaSlicer
			          toplevelDefinition: operation
			          criteria: { aViennaNode }
			          startNode: aViennaNode.
		self sliceNodes: slicer sliceNodes , { aViennaNode } ]
]

{ #category : 'highlighting' }
ViennaVDMDebuggerPresenter >> highlightVDMSource [

	| source highlighter result context |
	source := vdmSource text.
	vdmSource
		text: source;
		selectionInterval:
			(debugger session selectedVDMRangeForContext:
					 debugger currentContext).
	highlighter := ViennaVDMHighlighter new.
	highlighter text: source asText.
	context := ViennaPP2HighlightingContext new.
	result := highlighter parse: source withContext: context.
	result isPetit2Failure ifTrue: [
		highlighter text
			makeColor: Color red
			from: (context furthestPosition min: source size max: 1)
			to: source size ].
	sliceNodes ifNotNil: [
		sliceNodes do: [ :node |
			(tracingSource intervalForSource: node) key ifNotEmpty: [ :interval |
				highlighter text
					addAttribute: self sliceAttribute
					from: interval first
					to: interval last ] ] ].
	source size = highlighter text runs size ifTrue: [
		vdmSource withAdapterDo: [ :a |
			a widgetDo: [ :w |
				w text runs: highlighter text runs.
				w textArea ifNotNil: #compose ] ] ]
]

{ #category : 'initialization' }
ViennaVDMDebuggerPresenter >> initialize [

	super initialize.
	sliceNodes := Array new
]

{ #category : 'initialization' }
ViennaVDMDebuggerPresenter >> initializePresenters [

	super initializePresenters.
	vdmSource := self newText
		             contextMenu: [ self vdmSourceContextMenu ];
		             yourself.
	self initializeToolbar.
	vdmSource whenBuiltDo: [ self highlightVDMSource ]
]

{ #category : 'initialization' }
ViennaVDMDebuggerPresenter >> initializeToolbar [
	
	toolbar := self newToolbar
		addStyle: 'stToolbar';
		beIcons;
		fillWith: self toolbarActions
]

{ #category : 'initialization' }
ViennaVDMDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := aDebugger
]

{ #category : 'slicing' }
ViennaVDMDebuggerPresenter >> sliceAttribute [

	^ sliceAttribute ifNil: [
		  sliceAttribute := TextBackgroundColor color:
			                    (Color cyan mixed: 0.2 with: Color white) ]
]

{ #category : 'slicing' }
ViennaVDMDebuggerPresenter >> sliceNodes: aCollectionOfViennaNode [

	sliceNodes := aCollectionOfViennaNode.
	self sliceNodesChanged
]

{ #category : 'slicing' }
ViennaVDMDebuggerPresenter >> sliceNodesChanged [

	self highlightVDMSource
]

{ #category : 'initialization' }
ViennaVDMDebuggerPresenter >> toolbarActions [

	| group |
	group := (CmCommandGroup named: 'VDM Toolbar') asSpecGroup.
	group register: (ViennaStepIntoCommand forSpecContext: self).
	group register: (ViennaStepOverCommand forSpecContext: self).
	^ group
]

{ #category : 'updating' }
ViennaVDMDebuggerPresenter >> updatePresenter [

	super updatePresenter.
	self debugger interruptedContext isDead ifTrue: [ ^ self ].
	self updateVDMSource
]

{ #category : 'updating' }
ViennaVDMDebuggerPresenter >> updateVDMSource [

	debugger currentContext specification
		ifNil: [ vdmSource text: Text new ]
		ifNotNil: [ :spec |
			tracingSource := spec tracingSource.
			vdmSource
				text: tracingSource asString;
				selectionInterval:
					(debugger session selectedVDMRangeForContext:
							 debugger currentContext).
			self highlightVDMSource ]
]

{ #category : 'menus' }
ViennaVDMDebuggerPresenter >> vdmSourceContextMenu [

	| menu |
	menu := self newMenu.
	menu addGroup: [ :group |
		self vdmSourceSelectionNode ifNotNil: [ :node |
			(node
				 detectParent: #isViennaOperationDefinitionNode
				 ifNone: [ nil ]) ifNotNil: [
				group addItem: [ :item |
					item
						name: 'Highlight slice';
						action: [ self extractSliceOf: node ] ] ] ].
		(sliceNodes notNil and: [ sliceNodes notEmpty ]) ifTrue: [
			group addItem: [ :item |
				item
					name: 'Clear slice';
					action: [ self clearSlice ] ] ] ].
	^ menu
]

{ #category : 'selection' }
ViennaVDMDebuggerPresenter >> vdmSourceSelectionNode [

	^ tracingSource
		  nodeContaining: vdmSource selectionInterval
		  ifAbsent: [ nil ]
]

{ #category : 'selection' }
ViennaVDMDebuggerPresenter >> vdmSourceSelectionText [

	| text start end |
	text := vdmSource text asString.
	vdmSource selectionInterval in: [ :interval |
		start := interval first.
		end := interval last ].
	start > end ifTrue: [
		[ start > 1 and: [ (text at: start - 1) ~= Character cr ] ]
			whileTrue: [ start := start - 1 ].
		[ end < text size and: [ (text at: end + 1) ~= Character cr ] ]
			whileTrue: [ end := end + 1 ].
		vdmSource selectionInterval: (start to: end) ].
	^ (text copyFrom: start to: end) trim
]

{ #category : 'action' }
ViennaVDMDebuggerPresenter >> vdmStepInto [

	debugger session vdmStepInto: debugger context
]

{ #category : 'action' }
ViennaVDMDebuggerPresenter >> vdmStepOver [

	debugger session vdmStepOver: debugger context
]
