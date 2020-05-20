Class {
	#name : #WeblyBrowser,
	#superclass : #ViennaBrowser,
	#instVars : [
		'translationRuleSelection',
		'translationRulePane',
		'portField',
		'publishButton'
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

{ #category : #'translation pane' }
WeblyBrowser >> acceptTranslationRule: aString [
	| newTranslator |
	newTranslator := WWTTranslationRuleParser new parse: aString asString.
	newTranslator isPetit2Failure
		ifTrue: [ ^ false ].
	animation translator: newTranslator.
	^ true
]

{ #category : #'user interface' }
WeblyBrowser >> build [
	| pane webapiPane |
	translationRulePane := self buildTranslationRulePane.
	portField := self buildPortField.
	publishButton := self buildPublishButton.
	pane := super build.
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
	^ (PluggableTextMorph
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

{ #category : #'web api services' }
WeblyBrowser >> isPublished [
	^ animation isPublished
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
