Class {
	#name : #WeblyBrowser,
	#superclass : #ViennaBrowser,
	#instVars : [
		'translationRuleSelection',
		'portField',
		'publishButton',
		'frontPageSelection',
		'displayOperationField',
		'frontPageText',
		'translationRuleText',
		'guiModuleField',
		'handleEventOperationField'
	],
	#category : #'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : #menus }
WeblyBrowser class >> WeblyBrowserMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Webly WalkThrough')
		parent: #ViennaTalk;
		order: 0.3;
		action: [ self open ];
		help: 'open Webly Walk-Through';
		icon: nil
]

{ #category : #defaults }
WeblyBrowser class >> defaultLabel [
	^ 'Webly Walk-Through'
]

{ #category : #'class initialization' }
WeblyBrowser class >> initialize [
	super initialize.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : #'instance creation' }
WeblyBrowser class >> open [
	"WeblyBrowser open"

	^ self openOn: WeblyWalkThrough current
]

{ #category : #menus }
WeblyBrowser class >> viennaToolsMenuOn: aBuilder [
	<ViennaToolsMenu>
	(aBuilder item: #'Webly WalkThrough')
		order: 0.3;
		action: [ self open ];
		help: 'open Webly Walk-Through';
		icon: nil
]

{ #category : #'frontpage pane' }
WeblyBrowser >> acceptFrontPage: aStringOrText [
	animation frontPage: aStringOrText asString.
	^ true
]

{ #category : #'translation pane' }
WeblyBrowser >> acceptTranslationRule: aString [
	| newTranslator |
	newTranslator := WWTTranslationRuleParser new parse: aString asString.
	newTranslator isPetit2Failure
		ifTrue: [ ^ false ].
	animation translator: newTranslator.
	^ true
]

{ #category : #accessing }
WeblyBrowser >> animationClassForType: aSymbol [
	^ WeblyWalkThrough
]

{ #category : #'user interface' }
WeblyBrowser >> build [
	| pane frontPagePane |
	pane := super build.
	lowerTabPane addPage: self buildVisualsPane label: 'Visuals'.
	frontPagePane := self buildFrontPagePane.
	lowerTabPane addPage: frontPagePane label: 'HTML'.
	portField := self buildPortField.
	publishButton := self buildPublishButton.
	lowerTabPane addPage: self buildWebApiPane label: 'Web API'.
	self updateWidgets.
	^ pane
]

{ #category : #'user interface' }
WeblyBrowser >> buildDisplayEnabled [
	^ (CheckboxMorph
		on: self
		selected: #displayEnabled
		changeSelected: #displayEnabled:)
		height: self font height;
		width:
			(self font widthOfString: 'Enable ViennaVisuals')
				+ (self font height * 2);
		label: 'Enable ViennaVisuals'
]

{ #category : #'user interface' }
WeblyBrowser >> buildDisplayOperationField [
	^ displayOperationField := RubPluggableTextFieldMorph new
		on: self
			text: #displayOperation
			accept: #displayOperation:
			readSelection: nil
			menu: nil;
		setBalloonText: 'operation to build the display DOM';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		borderColor: Color lightGray;
		borderWidth: 1;
		width: 200;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildFrontPagePane [
	^ frontPageText := (RubPluggableTextMorph
		on: self
		text: #frontPage
		accept: #acceptFrontPage:
		readSelection: #frontPageSelection
		menu: #frontPagePaneMenu:shifted:
		setSelection: #frontPageSelection:)
		setBalloonText: 'html source to use the web API';
		font: ViennaLauncher font;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildGuiModuleField [
	^ guiModuleField := RubPluggableTextFieldMorph new
		on: self
			text: #guiModule
			accept: #guiModule:
			readSelection: nil
			menu: nil;
		setBalloonText: 'module that defines the display operation';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		borderColor: Color lightGray;
		borderWidth: 1;
		width: 200;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildHandleEventOperationField [
	^ handleEventOperationField := RubPluggableTextFieldMorph new
		on: self
			text: #handleEventOperation
			accept: #handleEventOperation:
			readSelection: nil
			menu: nil;
		setBalloonText: 'event handler operation';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		borderColor: Color lightGray;
		borderWidth: 1;
		width: 200;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildPortField [
	^ RubPluggableTextFieldMorph new
		on: self
			text: #port
			accept: #port:
			readSelection: nil
			menu: nil;
		setBalloonText: 'port number of the web api server';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		convertTo: Integer;
		hScrollbarShowNever;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildPublishButton [
	^ (PluggableButtonMorph
		on: self
		getState: #isPublished
		action: #togglePublish
		label: #publishButtonLabel)
		setBalloonText: 'toggle service on/off';
		color:
				(self isPublished
						ifTrue: [ self publishButtonOnColor ]
						ifFalse: [ self publishButtonOffColor ]);
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildTranslationRulePane [
	^ translationRuleText := (RubPluggableTextMorph
		on: self
		text: #translationRule
		accept: #acceptTranslationRule:
		readSelection: #translationRuleSelection
		menu: #translationPaneMenu:shifted:
		setSelection: #translationRuleSelection:)
		setBalloonText: 'VDM - JSON translation rule';
		font: ViennaLauncher font;
		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildVisualsPane [
	^ Morph new
		color: Color white;
		changeTableLayout;
		listDirection: #bottomToTop;
		listCentering: #topLeft;
		wrapCentering: #topLeft;
		cellPositioning: #topLeft;
		hResizing: #shrinkWrap;
		vResizing: #spaceFill;
		addMorph: self buildDisplayEnabled;
		addMorph:
			(Morph new
				color: Color white;
				changeTableLayout;
				listDirection: #rightToLeft;
				listCentering: #left;
				wrapCentering: #topLeft;
				hResizing: #shrinkWrap;
				vResizing: #spaceFill;
				addMorph: 'GUI module: ' asMorph;
				addMorph: self buildGuiModuleField;
				yourself);

		addMorph:
			(Morph new
				color: Color white;
				changeTableLayout;
				listDirection: #rightToLeft;
				listCentering: #left;
				wrapCentering: #topLeft;
				hResizing: #shrinkWrap;
				vResizing: #spaceFill;
				addMorph: 'display operation: ' asMorph;
				addMorph: self buildDisplayOperationField;
				yourself);

		addMorph:
			(Morph new
				color: Color white;
				changeTableLayout;
				listDirection: #rightToLeft;
				listCentering: #left;
				wrapCentering: #topLeft;
				hResizing: #shrinkWrap;
				vResizing: #spaceFill;
				addMorph: 'event handler: ' asMorph;
				addMorph: self buildHandleEventOperationField;
				yourself);


		yourself
]

{ #category : #'user interface' }
WeblyBrowser >> buildWebApiPane [
	^ Morph new
		color: Color white;
		changeProportionalLayout;
		addMorph: portField
			fullFrame:
			((0 @ 1 corner: 1 @ 1) asLayoutFrame
				rightOffset: -100;
				topOffset: -32;
				bottomOffset: 0;
				yourself);
		addMorph: publishButton
			fullFrame:
			((1 @ 1 corner: 1 @ 1) asLayoutFrame
				leftOffset: -100;
				topOffset: -32;
				yourself);
		addMorph: self buildTranslationRulePane
			fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -32;
				yourself);
		yourself
]

{ #category : #accessing }
WeblyBrowser >> displayEnabled [ 
	^ animation displayEnabled
]

{ #category : #accessing }
WeblyBrowser >> displayEnabled: aBoolean [
	animation displayEnabled: aBoolean.
	self updateWidgets
]

{ #category : #accessing }
WeblyBrowser >> displayOperation [
	^ animation displayOperation
]

{ #category : #accessing }
WeblyBrowser >> displayOperation: aString [
	animation displayOperation: aString
]

{ #category : #'frontpage pane' }
WeblyBrowser >> frontPage [
	^ animation frontPage
]

{ #category : #'frontpage pane menu' }
WeblyBrowser >> frontPagePaneMenu: aMenu shifted: aBoolean [
	aMenu target: self.
	aMenu
		addList:
			{{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('accept (s)' translated).
			#accept}.
			{('cancel (l)' translated).
			#cancel}}.
	^ aMenu
]

{ #category : #'frontpage pane' }
WeblyBrowser >> frontPageSelection [
	^ frontPageSelection ifNil: [ frontPageSelection := 1 to: 0 ]
]

{ #category : #'frontpage pane' }
WeblyBrowser >> frontPageSelection: anInterval [
	frontPageSelection := anInterval
]

{ #category : #accessing }
WeblyBrowser >> guiModule [
	^ animation guiModule
]

{ #category : #accessing }
WeblyBrowser >> guiModule: aString [
	animation guiModule: aString
]

{ #category : #accessing }
WeblyBrowser >> handleEventOperation [
	^ animation handleEventOperation
]

{ #category : #accessing }
WeblyBrowser >> handleEventOperation: aString [
	animation handleEventOperation: aString
]

{ #category : #'web api services' }
WeblyBrowser >> isPublished [
	^ animation isPublished
]

{ #category : #'module list menu' }
WeblyBrowser >> loadSnapshotFromFile [
	self
		fileOpen: 'Open snapshot...'
		extensions: #('webly' 'vdmim')
		do: [ :stream | 
			| json |
			json := (NeoJSONReader on: stream) next.
			[ animation
				specification: (json at: 'specification' ifAbsent: [ '' ])
				ifError: [ :msg | self error: msg ].
			self selectModuleNamed: nil ]
				on: Error
				do: [ :ex | 
					codePane setText: (json at: 'specification').
					codePane hasUnacceptedEdits: true ].
			animation state: (json at: 'state' ifAbsent: [ Dictionary new ]).
			self acceptWorkspace: (json at: 'workspace' ifAbsent: [ '' ]).
			self acceptFrontPage: (json at: 'frontpage' ifAbsent: [ '' ]).
			self
				acceptTranslationRule: (json at: 'translation' ifAbsent: [ '' ]) ]
]

{ #category : #'web api services' }
WeblyBrowser >> port [
	^ animation class server port
]

{ #category : #'web api services' }
WeblyBrowser >> port: anInteger [
	animation class server port: anInteger.
	self changed: #port.
	^ true
]

{ #category : #'web api services' }
WeblyBrowser >> publishButtonLabel [
	^ self isPublished
		ifTrue: [ 'Stop' ]
		ifFalse: [ 'Publish' ]
]

{ #category : #'web api services' }
WeblyBrowser >> publishButtonOffColor [
	^ Color green muchDarker
]

{ #category : #'web api services' }
WeblyBrowser >> publishButtonOnColor [
	^ Color green lighter
]

{ #category : #'module list menu' }
WeblyBrowser >> saveSnapshotToFile [
	| json |
	json := Dictionary new.
	json at: 'engineType' put: self animation engineType.
	json at: 'specification' put: self animation specification.
	json at: 'state' put: self animation state.
	json at: 'workspace' put: self workspace.
	json at: 'translation' put: self translationRule.
	json at: 'frontpage' put: self frontPage.
	self
		fileSave: 'Save snapshot to...'
		extensions: #('webly')
		do: [ :stream | (NeoJSONWriter on: stream) nextPut: json ]
]

{ #category : #'web api services' }
WeblyBrowser >> togglePublish [
	self isPublished
		ifTrue: [ 
			WeblyWalkThrough stopService.
			portField enabled: true.
			publishButton color: self publishButtonOffColor ]
		ifFalse: [ 
			portField enabled: false.
			WeblyWalkThrough startService.
			publishButton color: self publishButtonOnColor ].
	self changed: #isPublished.
	self changed: #publishButtonLabel.
	publishButton changed
]

{ #category : #'translation pane menu' }
WeblyBrowser >> translationPaneMenu: aMenu shifted: aBoolean [
	aMenu target: self.
	aMenu
		addList:
			{{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('accept (s)' translated).
			#accept}.
			{('cancel (l)' translated).
			#cancel}}.
	^ aMenu
]

{ #category : #'translation pane' }
WeblyBrowser >> translationRule [
	^ animation translator source
]

{ #category : #'translation pane' }
WeblyBrowser >> translationRuleSelection [
	^ translationRuleSelection ifNil: [ translationRuleSelection := 1 to: 0 ]
]

{ #category : #'translation pane' }
WeblyBrowser >> translationRuleSelection: aSelection [
	translationRuleSelection := aSelection
]

{ #category : #'user interface' }
WeblyBrowser >> updateWidgets [
	| visualsMode |
	visualsMode := self displayEnabled.
	guiModuleField
		enabled: visualsMode;
		textColor:
			(visualsMode
				ifTrue: [ Color black ]
				ifFalse: [ Color lightGray ]).
	displayOperationField
		enabled: visualsMode;
		textColor:
			(visualsMode
				ifTrue: [ Color black ]
				ifFalse: [ Color lightGray ]).
	handleEventOperationField
		enabled: visualsMode;
		textColor:
			(visualsMode
				ifTrue: [ Color black ]
				ifFalse: [ Color lightGray ]).
	translationRuleText
		enabled: visualsMode not;
		textColor:
			(visualsMode not
				ifTrue: [ Color black ]
				ifFalse: [ Color lightGray ]).
	frontPageText
		enabled: visualsMode not;
		textColor:
			(visualsMode not
				ifTrue: [ Color black ]
				ifFalse: [ Color lightGray ])
]

{ #category : #'module list menu' }
WeblyBrowser >> useInterpreter [
	self shouldNotImplement
]

{ #category : #'module list menu' }
WeblyBrowser >> useTranspiler [
	self shouldNotImplement
]
