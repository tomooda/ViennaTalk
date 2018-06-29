Class {
	#name : #LivelyWalkThrough,
	#superclass : #Model,
	#instVars : [
		'director'
	],
	#classVars : [
		'Server'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LivelyWalkThrough class >> default [
	^ self on: LWTDirector default
]

{ #category : #utilities }
LivelyWalkThrough class >> fileOpen: title extensions: exts path: path preview: preview [
	"LivelyWalkThrough fileOpen: 'title' extensions: #('png' 'jpg') path: nil preview: #image"

	| ui fd |
	ui := UIManager default.
	fd := FileDialogWindow basicNew
		basicTheme: ui theme;
		previewType: preview;
		initialize;
		title: title;
		answerPathName.
	exts ifNotNil: [ fd validExtensions: exts ].
	path ifNotNil: [ fd selectPathName: (FileSystem disk pathFromString: path) parent asFileReference fullName ].
	^ (ui openModal: fd) answer ifNotNil: [ :ans | ans asFileReference ]
]

{ #category : #'world menu' }
LivelyWalkThrough class >> livelyWalkThroughMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openVDMJ ];
		order: 0.481;
		parent: #Tools;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil.
	aBuilder withSeparatorAfter
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> on: aLWTDirector [
	^ self new director: aLWTDirector
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

{ #category : #'user interface' }
LivelyWalkThrough >> build [
	| pane utilsPane |
	pane := BorderedMorph new
		extent: 900 @ 600;
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	utilsPane := LazyTabGroupMorph new.
	utilsPane
		addLazyPage: self buildWidgetDispenserPane label: 'Widgets';
		addLazyPage: self buildVDMBrowserPane label: 'VDM';
		addLazyPage: self buildLivetalkBrowserPane label: 'Livetalk';
		addLazyPage: self buildSettingsPane label: 'Settings';
		addLazyPage: self buildFilePane label: 'File'.
	utilsPane selectedPageIndex: 1.
	pane
		addMorph: self director
		fullFrame:
			((0 @ 0 corner: 0.6 @ 1) asLayoutFrame
				bottomRightOffset: -3 @ 0;
				yourself).
	pane
		addMorph: utilsPane
		fullFrame:
			((0.6 @ 0 corner: 1 @ 1) asLayoutFrame
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
	| pane urlPrefixPane |
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
		addMorphBack:
				(' name ' asMorph
						hResizing: #rigid;
						yourself);
		addMorphBack:
				((PluggableTextMorph on: self director text: #urlPrefix accept: #acceptUrlPrefix:)
						autoAccept: true;
						extent: 100 @ (TextStyle default defaultFont height * 2);
						hResizing: #spaceFill;
						yourself).
	pane addMorphBack: urlPrefixPane.
	^ pane
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildVDMBrowserPane [
	^ (ViennaBrowser on: self director vdmc) build
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
