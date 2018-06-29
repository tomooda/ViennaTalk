Class {
	#name : #LWTLivetalkBrowser,
	#superclass : #Model,
	#instVars : [
		'director',
		'codePane',
		'codeSelection',
		'selectedScriptSelector'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LWTLivetalkBrowser class >> on: aLWTDirector [
	^ self new
		director: aLWTDirector;
		yourself
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> acceptCode: aStringOrText [
	aStringOrText asString ~= self code asString
		ifTrue: [ 
			| codeStream selector |
			codeStream := aStringOrText asString readStream.
			selector := (codeStream upTo: Character cr) trimmed.
			(LWTLivetalkScript
				named: selector
				on: self director
				source: codeStream upToEnd
				ifFail: [ 
					codePane flash.
					^ false ])
				ifNotNil: [ :script | 
					self director addScript: script.
					codePane hasUnacceptedEdits: false.
					self changed: #scriptList.
					self selectScriptNamed: selector.
					^ true ] ]
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> build [
	| scriptList browserPane |
	scriptList := self buildScriptList.
	codePane := self buildCodePane.
	browserPane := BorderedMorph new
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	browserPane addMorph: scriptList fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	browserPane addMorph: codePane fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	browserPane addPaneSplitters.
	^ browserPane
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> buildCodePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		askBeforeDiscardingEdits: true;
		yourself
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> buildScriptList [
	^ PluggableListMorph
		on: self
		list: #scriptList
		selected: #scriptListIndex
		changeSelected: #scriptListIndex:
		menu: #scriptListMenu:shifted:
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> code [
	^ self selectedScriptSelector
		ifNotNil: [ :selector | 
			(self director scriptAt: selector ifAbsent: [  ])
				ifNotNil: [ :script | (selector , String cr , script source) asText makeAllColor: Color black ]
				ifNil: [ self codeTemplate ] ]
		ifNil: [ self codeTemplate ]
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeSelection [
	^ codeSelection ifNil: [ codeSelection := 1 to: 0 ]
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeSelection: anInterval [
	codeSelection := anInterval.
	[ 
	self director
		selectedWidgets:
			((self director morphNamed: codePane textMorph editor selection asString ifAbsent: [ nil ])
				ifNil: [ #() ]
				ifNotNil: [ :morph | Array with: morph ]) ]
		on: Error
		do: [ :ex | self director selectedWidgets: #() ]
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeTemplate [
	^ '<widget name>`<event>
	<number literal>
	<string literal>
	[<widget name>]
	<vdm function or operation>(<args>)
	<expression> -> [<widget name>]
	! <expression>' asText makeAllColor: Color gray
]

{ #category : #defaults }
LWTLivetalkBrowser >> defaultTitle [
	^ 'Livetalk Browser'
]

{ #category : #accessing }
LWTLivetalkBrowser >> director [
	^ director
]

{ #category : #accessing }
LWTLivetalkBrowser >> director: aLWTDirector [
	director ifNotNil: [ director removeDependent: self ].
	director := aLWTDirector.
	director addDependent: self
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> doIt [
	self selectedScript
		ifNotNilDo: [:script | script value]
]

{ #category : #'script list' }
LWTLivetalkBrowser >> hasScriptSelected [
	^ selectedScriptSelector notNil
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> inspectDirector [
	self director inspect
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> inspectIt [
	self selectedScript
		ifNotNilDo: [:script | script value inspect]
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> openLabel: aString [
	self build openInWindowLabeled: aString
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> removeScript [
	self director
		removeScriptAt: self selectedScriptSelector
		ifAbsent: [].
	self changed: #scriptList.
	self selectScriptNamed: nil
]

{ #category : #'script list' }
LWTLivetalkBrowser >> scriptList [
	^ self director scriptSelectors
]

{ #category : #'script list' }
LWTLivetalkBrowser >> scriptListIndex [
	^ self scriptList indexOf: self selectedScriptSelector
]

{ #category : #'script list' }
LWTLivetalkBrowser >> scriptListIndex: anInteger [ 
	self
		selectScriptNamed: (self scriptList
				at: anInteger
				ifAbsent: [])
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> scriptListMenu: aMenu shifted: shifted [ 
	"Answer the message-list menu"
	shifted
		ifTrue: [^ self shiftedScriptListMenu: aMenu].
	aMenu addList: #(
		#('do it (d)' #doIt )
		-
		#('remove (x)' #removeScript )
	).
	^ aMenu
]

{ #category : #'script list' }
LWTLivetalkBrowser >> selectScriptNamed: aSymbol [ 
	selectedScriptSelector := aSymbol
				ifNotNil: [:selector | selector asSymbol].
	self changed: #scriptListIndex.
	self changed: #code
]

{ #category : #'script list' }
LWTLivetalkBrowser >> selectedScript [
	^ self director
		scriptAt: self selectedScriptSelector
		ifAbsent: []
]

{ #category : #'script list' }
LWTLivetalkBrowser >> selectedScriptSelector [
	^ selectedScriptSelector
]

{ #category : #'script list menu' }
LWTLivetalkBrowser >> shiftedScriptListMenu: aMenu [
	aMenu addList: #(
			('inspect editor'		inspect)
			('inspect director'		inspectDirector)).
	^ aMenu
]

{ #category : #updating }
LWTLivetalkBrowser >> update: aSymbol [
	aSymbol = #scriptSelectors ifTrue: [ self changed: #scriptList ].
	^ super update: aSymbol
]
