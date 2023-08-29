Class {
	#name : #ViennaVDMDebuggerPresenter,
	#superclass : #StPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'vdmSource',
		'toolbar'
	],
	#category : #'ViennaTalk-Transpiler-Debugger'
}

{ #category : #'debugger extension' }
ViennaVDMDebuggerPresenter class >> defaultDisplayOrder [

	^ 1
]

{ #category : #layout }
ViennaVDMDebuggerPresenter class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #toolbar expand: false fill: false padding: 0;
		add: #vdmSource;
		yourself
]

{ #category : #'debugger extension' }
ViennaVDMDebuggerPresenter class >> showInDebugger [

	^ showDebuggerExtension ifNil: [ showDebuggerExtension := true ]
]

{ #category : #visiting }
ViennaVDMDebuggerPresenter >> accept: aVisitor [

	^ aVisitor visitVDM: self
]

{ #category : #'debugger extension' }
ViennaVDMDebuggerPresenter >> debuggerExtensionToolName [

	^ 'VDM'
]

{ #category : #highlighting }
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
	source size = highlighter text runs size ifTrue: [
		vdmSource withAdapterDo: [ :a |
			a widgetDo: [ :w |
				w text runs: highlighter text runs.
				w changed ] ] ]
]

{ #category : #initialization }
ViennaVDMDebuggerPresenter >> initializePresenters [

	super initializePresenters.
	vdmSource := self newText.
	self initializeToolbar.
	vdmSource whenBuiltDo: [ self highlightVDMSource ]
]

{ #category : #initialization }
ViennaVDMDebuggerPresenter >> initializeToolbar [
	
	toolbar := self newToolbar
		addStyle: 'stToolbar';
		beIcons;
		fillWith: self toolbarActions
]

{ #category : #initialization }
ViennaVDMDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := aDebugger.
	debugger session: debugger session asViennaDebugSession
]

{ #category : #initialization }
ViennaVDMDebuggerPresenter >> toolbarActions [

	| group |
	group := (CmCommandGroup named: 'VDM Toolbar') asSpecGroup.
	group register: (ViennaStepIntoCommand forSpecContext: self).
	group register: (ViennaStepOverCommand forSpecContext: self).
	^ group
]

{ #category : #updating }
ViennaVDMDebuggerPresenter >> updatePresenter [

	super updatePresenter.
	self debugger interruptedContext isDead ifTrue: [ ^ self ].
	self updateVDMSource
]

{ #category : #updating }
ViennaVDMDebuggerPresenter >> updateVDMSource [

	debugger currentContext specification
		ifNil: [ vdmSource text: Text new ]
		ifNotNil: [ :spec |
			vdmSource
				text: spec source;
				selectionInterval:
					(debugger session selectedVDMRangeForContext:
							 debugger currentContext).
			self highlightVDMSource ]
]

{ #category : #action }
ViennaVDMDebuggerPresenter >> vdmStepInto [

	debugger session vdmStepInto: debugger context
]

{ #category : #action }
ViennaVDMDebuggerPresenter >> vdmStepOver [

	debugger session vdmStepOver: debugger context
]
