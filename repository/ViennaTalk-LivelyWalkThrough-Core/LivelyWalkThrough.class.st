Class {
	#name : #LivelyWalkThrough,
	#superclass : #Model,
	#instVars : [
		'director'
	],
	#classVars : [
		'Server'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LivelyWalkThrough class >> default [
	^ self on: LWTDirector default
]

{ #category : #utilities }
LivelyWalkThrough class >> fileOpen: title extensions: exts path: path preview: preview [
	"LivelyWalkThrough fileOpen: 'title' extensions: #('png' 'jpg') path: nil preview: #image"

	| ref ui fd |
	ref := path isString ifTrue: [ (FileSystem disk pathFromString: path)  asFileReference ] ifFalse: [ path  ].
	ui := UIManager default.
	fd := FileDialogWindow basicNew
		basicTheme: ui theme;
		previewType: preview;
		initialize;
		title: title;
		answerPathName.
	exts ifNotNil: [ fd validExtensions: exts ].
	path ifNotNil: [ fd selectPath: ref parent  ].
	^ (ui openModal: fd) answer ifNotNil: [ :ans | ans asFileReference ]
]

{ #category : #'class initialization' }
LivelyWalkThrough class >> initialize [
	self installEventHandlers.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : #'class initialization' }
LivelyWalkThrough class >> installEventHandlers [
	ExternalDropHandler
		registerHandler:
			(ExternalDropHandler
				type: nil
				extension: 'lwt'
				action: [ :stream :pasteUp :event | LivelyWalkThrough openDefault director loadStream: stream ])
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> on: aLWTDirector [
	^ self new director: aLWTDirector
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> openDefault [
	^ self default open
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> openVDMJ [
	^ self vdmj open
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> vdmj [
	"LivelyWalkThrough vdmj open"

	^ self on: LWTDirector vdmj
]

{ #category : #'world menu' }
LivelyWalkThrough class >> viennaToolsMenuOn: aBuilder [
	<ViennaToolsMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openDefault ];
		order: 0.2;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil
]

{ #category : #'world menu' }
LivelyWalkThrough class >> worldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openDefault ];
		order: 0.3;
		parent: #ViennaTalk;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil
]

{ #category : #'user interface' }
LivelyWalkThrough >> build [

	| pane utilsPane |
	pane := BorderedMorph new
		        extent: 900 @ 600;
		        color: Color transparent;
		        changeProportionalLayout;
		        yourself.
	utilsPane := TabGroupMorph new.
	utilsPane
		addPage: self buildWidgetDispenserPane label: 'Widgets';
		addPage: self buildVDMBrowserPane label: 'VDM';
		addPage: self buildLivetalkBrowserPane label: 'Livetalk';
		addPage: self buildSettingsPane label: 'Settings';
		addPage: self buildFilePane label: 'File'.
	utilsPane selectedPageIndex: 1.
	pane
		addMorph: self director
		fullFrame: ((0 @ 0 corner: 0.6 @ 1) asLayoutFrame
				 bottomRightOffset: -3 @ 0;
				 yourself).
	pane
		addMorph: utilsPane
		fullFrame: ((0.6 @ 0 corner: 1 @ 1) asLayoutFrame
				 topLeftOffset: 3 @ 0;
				 yourself).
	pane addPaneSplitters.
	^ pane
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildFilePane [
	| pane |
	pane := Morph new.
	pane
		color: Color white;
		changeTableLayout;
		listDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		listCentering: #topLeft;
		wrapCentering: #topLeft.
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Load...';
				actionBlock: [ self director load ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Save...';
				actionBlock: [ self director save ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Save As...';
				actionBlock: [ self director saveAs ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	^ pane
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildLivetalkBrowserPane [
	^ (LWTLivetalkBrowser on: self director) build
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildSettingsPane [

	| pane urlPrefixPane animationPane |
	pane := Morph new.
	pane
		color: Color white;
		changeTableLayout;
		listDirection: #topToBottom.
	urlPrefixPane := Morph new.
	urlPrefixPane
		color: Color white;
		changeTableLayout;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	urlPrefixPane
		addMorphBack: (' name ' asMorph
				 hResizing: #rigid;
				 yourself);
		addMorphBack: ((RubPluggableTextMorph
				  on: self director
				  text: #urlPrefix
				  accept: #acceptUrlPrefix:
				  readSelection: nil
				  menu: nil)
				 autoAccept: true;
				 extent: 100 @ (TextStyle default defaultFont height * 2);
				 hResizing: #spaceFill;
				 yourself).
	pane addMorphBack: urlPrefixPane.
	(Smalltalk includesKey: #ViennaTranspiledAnimation) ifTrue: [ 
		animationPane := Morph new.
		animationPane
			color: Color white;
			changeTableLayout;
			listDirection: #leftToRight;
			hResizing: #spaceFill;
			vResizing: #shrinkWrap.
		animationPane addMorphBack: ((CheckboxMorph
				  on: self director
				  selected: #usesTranspiler
				  changeSelected: #usesTranspiler:)
				 label: 'use transpiler';
				 yourself).
		pane addMorphBack: animationPane ].
	^ pane
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildVDMBrowserPane [
	^ (ViennaBrowser on: self director animation) build
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildWidgetDispenserPane [
	^ LWTWidgetDispenser new
]

{ #category : #accessing }
LivelyWalkThrough >> director [
	^ director
]

{ #category : #accessing }
LivelyWalkThrough >> director: aLWTDirector [
	director := aLWTDirector
]

{ #category : #'user interface' }
LivelyWalkThrough >> open [
	^ self openLabel: 'Lively Walk-Through'
]

{ #category : #'user interface' }
LivelyWalkThrough >> openLabel: aString [
	self build openInWindowLabeled: aString
]
