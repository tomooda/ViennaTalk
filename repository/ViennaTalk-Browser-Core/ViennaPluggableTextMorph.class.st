Class {
	#name : #ViennaPluggableTextMorph,
	#superclass : #PluggableTextMorph,
	#instVars : [
		'highlighter',
		'wantsHighlighting'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'enabling/disabling' }
ViennaPluggableTextMorph >> disableHighlighting [
	self highlightingEnabled: false
]

{ #category : #'enabling/disabling' }
ViennaPluggableTextMorph >> enableHighlighting [
	self highlightingEnabled: true
]

{ #category : #'editor access' }
ViennaPluggableTextMorph >> handleEdit: aBlock [
	^ [ super handleEdit: aBlock ]
		ensure: [ wantsHighlighting := true ]
]

{ #category : #'stepping and presenter' }
ViennaPluggableTextMorph >> highlight [
	| source |
	highlighter ifNil: [^ self stopStepping ].
	source := self text asString.
	wantsHighlighting := false.
	highlighter text: source asText.
	highlighter parse: source.
	self text runs: highlighter text runs
]

{ #category : #accessing }
ViennaPluggableTextMorph >> highlightingEnabled [
	^ highlighter notNil
]

{ #category : #accessing }
ViennaPluggableTextMorph >> highlightingEnabled: aBoolean [
	aBoolean = true
		ifTrue: [ 
			highlighter := ViennaVDMHighlighter new.
			self startStepping ]
		ifFalse: [ highlighter := nil ]
]

{ #category : #'initialize-release' }
ViennaPluggableTextMorph >> initialize [
	super initialize.
	highlighter := nil.
	wantsHighlighting := false
]

{ #category : #'event handling' }
ViennaPluggableTextMorph >> keyStroke: aKeyboardEvent [
	wantsHighlighting := true.
	^ super keyStroke: aKeyboardEvent
]

{ #category : #accessing }
ViennaPluggableTextMorph >> setText: aText [
	super setText: aText.
	self highlight
]

{ #category : #'stepping and presenter' }
ViennaPluggableTextMorph >> step [
	self wantsHighlighting
		ifTrue: [ self highlight ].
	self changed
]

{ #category : #'stepping and presenter' }
ViennaPluggableTextMorph >> stepTime [
	^ 1000
]

{ #category : #'menu commands' }
ViennaPluggableTextMorph >> template [
	self handleEdit: [ textMorph editor template ]
]

{ #category : #'class access' }
ViennaPluggableTextMorph >> textMorphClass [
	"Answer the class used to create the receiver's textMorph"
	
	^ViennaTextMorphForEditView 
]

{ #category : #updating }
ViennaPluggableTextMorph >> update: aSymbol [
	(aSymbol == getTextSelector and: [ self canDiscardEdits not ])
		ifTrue: [ 
			| choice |
			choice := UIManager default
				confirm: 'Code has been modified.\What do you want to do?' translated withCRs
				trueChoice: 'Accept' translated
				falseChoice: 'Discard' translated
				cancelChoice: 'Cancel' translated
				default: nil.
			choice ifNil: [ ^ nil ].
			choice
				ifTrue: [ 
					self hasUnacceptedEdits: false.
					model perform: setTextSelector with: textMorph contents ] ].
	^ super update: aSymbol
]

{ #category : #accessing }
ViennaPluggableTextMorph >> wantsHighlighting [
	^ wantsHighlighting = true
]

{ #category : #accessing }
ViennaPluggableTextMorph >> wantsHighlighting: aBoolean [
	wantsHighlighting := aBoolean = true
]

{ #category : #testing }
ViennaPluggableTextMorph >> wantsSteps [
	^ self highlightingEnabled
]
