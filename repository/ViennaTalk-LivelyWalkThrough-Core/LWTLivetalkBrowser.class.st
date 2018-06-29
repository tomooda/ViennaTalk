Class {
	#name : #LWTLivetalkBrowser,
	#superclass : #Model,
	#instVars : [
		'director',
		'codePane',
		'selectedActionSelector',
		'codeSelection'
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
			(LWTLivetalkScriptAction
				named: selector
				on: self director
				source: codeStream upToEnd
				notifying: codePane
				ifFail: [ 
					codePane flash.
					nil ])
				ifNil: [ ^ false ]
				ifNotNil: [ :action | 
					self director actionAt: selector asSymbol put: action.
					codePane hasUnacceptedEdits: false.
					self changed: #actionList.
					self selectActionNamed: selector.
					^ true ] ]
]

{ #category : #'action list' }
LWTLivetalkBrowser >> actionList [
	^ self director actionSelectors
]

{ #category : #'action list' }
LWTLivetalkBrowser >> actionListIndex [
	^ self actionList indexOf: self selectedActionSelector
]

{ #category : #'action list' }
LWTLivetalkBrowser >> actionListIndex: anInteger [ 
	self
		selectActionNamed: (self actionList
				at: anInteger
				ifAbsent: [])
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> actionListMenu: aMenu shifted: shifted [ 
	"Answer the message-list menu"
	shifted
		ifTrue: [^ self shiftedActionListMenu: aMenu].
	aMenu addList: #(
		#('do it (d)' #doIt )
		-
		#('remove (x)' #removeAction )
	).
	^ aMenu
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> build [
	| actionList browserPane |
	actionList := self buildActionList.
	codePane := self buildCodePane.
	browserPane := BorderedMorph new
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	browserPane addMorph: actionList fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	browserPane addMorph: codePane fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	browserPane addPaneSplitters.
	^ browserPane
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> buildActionList [
	^ PluggableListMorph
		on: self
		list: #actionList
		selected: #actionListIndex
		changeSelected: #actionListIndex:
		menu: #actionListMenu:shifted:
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

{ #category : #'code pane' }
LWTLivetalkBrowser >> code [
	^ self selectedActionSelector
		ifNotNilDo: [ :selector | 
			(self director actionAt: selector ifAbsent: [  ])
				ifNotNilDo: [ :action | (selector , String cr , action source) asText makeAllColor: Color black ]
				ifNil: [ self codeTemplate ] ]
		ifNil: [ self codeTemplate ]
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeSelection [
	^ codeSelection ifNil: [ codeSelection := 1 to: 0 ]
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeSelection: anInterval [
	codeSelection := anInterval
]

{ #category : #'code pane' }
LWTLivetalkBrowser >> codeTemplate [
	^ 'ScriptName
	VDM`operation(arg) -> [UI]
	<ScriptName>
	!"dialogMessage"' asText makeAllColor: Color gray
]

{ #category : #defaults }
LWTLivetalkBrowser >> defaultBackgroundColor [
	^ Color blue
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
	director := aLWTDirector
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> doIt [
	self selectedAction
		ifNotNilDo: [:action | action value]
]

{ #category : #'action list' }
LWTLivetalkBrowser >> hasActionSelected [
	^ selectedActionSelector notNil
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> inspectDirector [
	self director inspect
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> inspectIt [
	self selectedAction
		ifNotNilDo: [:action | action value inspect]
]

{ #category : #'user interface' }
LWTLivetalkBrowser >> openLabel: aString [
	self build openInWindowLabeled: aString
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> removeAction [
	self director
		removeActionAt: self selectedActionSelector
		ifAbsent: [].
	self changed: #actionList.
	self actionListIndex < 1
		ifTrue: [self changed: #contents]
]

{ #category : #'action list' }
LWTLivetalkBrowser >> selectActionNamed: aSymbol [ 
	selectedActionSelector := aSymbol
				ifNotNilDo: [:selector | selector asSymbol].
	self changed: #actionListIndex.
	self changed: #code
]

{ #category : #'action list' }
LWTLivetalkBrowser >> selectedAction [
	^ self director
		actionAt: self selectedActionSelector
		ifAbsent: []
]

{ #category : #'action list' }
LWTLivetalkBrowser >> selectedActionSelector [
	^ selectedActionSelector
]

{ #category : #'action list menu' }
LWTLivetalkBrowser >> shiftedActionListMenu: aMenu [
	aMenu addList: #(
			('inspect editor'		inspect)
			('inspect director'		inspectDirector)).
	^ aMenu
]
