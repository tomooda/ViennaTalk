Class {
	#name : #LWTRemoteWidget,
	#superclass : #LWTFieldWidget,
	#instVars : [
		'url'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #accessing }
LWTRemoteWidget >> acceptContents: aStringOrText [
	| oldContents |
	oldContents := contents.
	super acceptContents: aStringOrText.
	ZnEasy put: self url asUrl data: (ZnEntity text: aStringOrText).
	^ true
]

{ #category : #json }
LWTRemoteWidget >> asJsonObject [
	^ super asJsonObject
		at: 'url' put: self url;
		yourself
]

{ #category : #accessing }
LWTRemoteWidget >> basename [
	^ 'Remote'
]

{ #category : #accessing }
LWTRemoteWidget >> basicContents [
	^ super contents
]

{ #category : #'initialize-release' }
LWTRemoteWidget >> buildTextPane [
	textMorph := PluggableTextMorph
		on: self
		text: #basicContents
		accept: #acceptContents:
		readSelection: nil
		menu: #textPaneMenu:shifted:.
	textMorph
		acceptOnCR: true;
		acceptOnFocusChange: true;
		borderColor: Color black;
		borderWidth: 1;
		font: self textFont;
		showHScrollBarOnlyWhenNeeded: true;
		hideVScrollBarIndefinitely: false;
		disable.
	self changeProportionalLayout.
	self addMorph: textMorph fullFrame: self layoutFrameForTextPane.
	^ textMorph
]

{ #category : #operations }
LWTRemoteWidget >> changeUrl [
	(UIManager default request: 'Enter a new URL' initialAnswer: self url) ifNotNil: [ :newUrl | self url: newUrl ]
]

{ #category : #accessing }
LWTRemoteWidget >> contents [
	| newContents |
	newContents := [ (ZnEasy get: self url asUrl) entity contents ]
		on: Error
		do: [ :ex | ^ super contents ].
	super acceptContents: newContents.
	self changed: #basicContents.
	^ self contentsToValue: newContents
]

{ #category : #'event handling' }
LWTRemoteWidget >> handlesMouseDown: anEvent [
	^ frozen not
]

{ #category : #'initialize-release' }
LWTRemoteWidget >> initialize [
	super initialize.
	url := String new
]

{ #category : #menu }
LWTRemoteWidget >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'url...' translated target: self selector: #changeUrl.
	^ menu
]

{ #category : #accessing }
LWTRemoteWidget >> url [
	^ url
]

{ #category : #accessing }
LWTRemoteWidget >> url: aString [
	url := aString
]
