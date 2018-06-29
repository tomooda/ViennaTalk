Class {
	#name : #WeblyBrowser,
	#superclass : #ViennaBrowser,
	#instVars : [
		'translationRuleSelection',
		'translationRulePane'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : #defaults }
WeblyBrowser class >> defaultLabel [
	^ 'Webly Walk-Through'
]

{ #category : #'instance creation' }
WeblyBrowser class >> open [
	"WeblyBrowser open"

	^ self openOn: WeblyWalkThrough current
]

{ #category : #'translation pane' }
WeblyBrowser >> acceptTranslationRule: aString [
	| newTranslator |
	newTranslator := WWTTranslationRuleParser new parse: aString asString.
	newTranslator isPetitFailure
		ifTrue: [ ^ false ].
	vdmc translator: newTranslator.
	^ true
]

{ #category : #'user interface' }
WeblyBrowser >> build [
	| pane |
	translationRulePane := self buildTranslationRulePane.
	pane := super build.
	lowerTabPane addLazyPage: translationRulePane label: 'Translation'.
	^ pane
]

{ #category : #'user interface' }
WeblyBrowser >> buildTranslationRulePane [
	^ (PluggableTextMorph
		on: self
		text: #translationRule
		accept: #acceptTranslationRule:
		readSelection: #translationRuleSelection
		menu: #translationRulePaneMenu:shifted:
		setSelection: #translationRuleSelection:)
		askBeforeDiscardingEdits: true;
		yourself
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
	^ vdmc translator source
]

{ #category : #'translation pane' }
WeblyBrowser >> translationRuleSelection [
	^ translationRuleSelection ifNil: [ translationRuleSelection := 1 to: 0 ]
]

{ #category : #'translation pane' }
WeblyBrowser >> translationRuleSelection: aSelection [
	translationRuleSelection := aSelection
]
