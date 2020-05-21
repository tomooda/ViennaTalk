Class {
	#name : #WeblyBrowser,
	#superclass : #ViennaBrowser,
	#instVars : [
		'translationRuleSelection',
		'translationRulePane',
		'portField',
		'publishButton',
		'frontPageSelection'
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
	| pane frontPagePane webapiPane |
	pane := super build.
	frontPagePane := self buildFrontPagePane.
	lowerTabPane addPage: frontPagePane label: 'HTML'.
	translationRulePane := self buildTranslationRulePane.
	portField := self buildPortField.
	publishButton := self buildPublishButton.
	webapiPane := Morph new.
	webapiPane changeProportionalLayout.
	webapiPane
		addMorph: portField
		fullFrame:
			((0 @ 1 corner: 1 @ 1) asLayoutFrame
				rightOffset: -100;
				topOffset: -32;
				yourself).
	webapiPane
		addMorph: publishButton
		fullFrame:
			((1 @ 1 corner: 1 @ 1) asLayoutFrame
				leftOffset: -100;
				topOffset: -32;
				yourself).
	webapiPane
		addMorph: translationRulePane
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -32;
				yourself).
	lowerTabPane addPage: webapiPane label: 'Web API'.
	^ pane
]

{ #category : #'user interface' }
WeblyBrowser >> buildFrontPagePane [
	^ (RubPluggableTextMorph
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
WeblyBrowser >> buildPortField [
	^ (PluggableTextFieldMorph on: self text: #port accept: #port:)
		setBalloonText: 'port number of the web api server';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		convertTo: Integer;
		hideScrollBarsIndefinitely: true;
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
	^ (RubPluggableTextMorph
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

{ #category : #'web api services' }
WeblyBrowser >> isPublished [
	^ animation isPublished
]

{ #category : #'module list menu' }
WeblyBrowser >> loadSnapshotFromFile [
	self
		fileOpen: 'Open snapshot...'
		extensions: #('vdmim')
		do: [ :stream | 
			| json |
			json := (NeoJSONReader on: stream) next.
			animation := (self
				animationClassForType: (json at: 'engineType' ifAbsent: [ nil ]) asSymbol)
				new.
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
			portField enable.
			publishButton color: self publishButtonOffColor ]
		ifFalse: [ 
			portField disable.
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

{ #category : #'module list menu' }
WeblyBrowser >> useInterpreter [
	self shouldNotImplement
]

{ #category : #'module list menu' }
WeblyBrowser >> useTranspiler [
	self shouldNotImplement
]
