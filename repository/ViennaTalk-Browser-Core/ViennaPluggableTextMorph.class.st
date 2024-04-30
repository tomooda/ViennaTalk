Class {
	#name : 'ViennaPluggableTextMorph',
	#superclass : 'RubPluggableTextMorph',
	#instVars : [
		'highlighter',
		'wantsHighlighting',
		'highlighterProcess'
	],
	#classVars : [
		'DefaultHighlightingEnabled'
	],
	#category : 'ViennaTalk-Browser-Core-Morphic',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Morphic'
}

{ #category : 'accessing' }
ViennaPluggableTextMorph class >> defaultHighlightingEnabled [
	^ DefaultHighlightingEnabled ifNil: [ DefaultHighlightingEnabled := true ]
]

{ #category : 'accessing' }
ViennaPluggableTextMorph class >> defaultHighlightingEnabled: aBoolean [
	DefaultHighlightingEnabled := aBoolean ~= false
]

{ #category : 'settings' }
ViennaPluggableTextMorph class >> viennaSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #syntaxHighlighting)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #defaultHighlightingEnabled;
		setSelector: #defaultHighlightingEnabled:;
		description: 'If checked, then VDM source will be syntax-highlighted.';
		label: 'Syntax highlighting';
		order: 0.6
]

{ #category : 'enabling/disabling' }
ViennaPluggableTextMorph >> disableHighlighting [
	self highlightingEnabled: false
]

{ #category : 'enabling/disabling' }
ViennaPluggableTextMorph >> enableHighlighting [
	self highlightingEnabled: true
]

{ #category : 'editor access' }
ViennaPluggableTextMorph >> handleEdit: aBlock [
	| result |

	self textMorph editor 
		selectFrom: self selectionInterval first 
		to: self selectionInterval last.
	self textMorph handleEdit: [result := aBlock value].   "Update selection after edit"
	self textChanged.
	self wantsHighlighting: true.
	^ result
]

{ #category : 'stepping and presenter' }
ViennaPluggableTextMorph >> highlight [
	| source |
	highlighter ifNil: [ ^ self stopStepping ].
	highlighterProcess
		ifNotNil: [ highlighterProcess terminate.
			highlighterProcess := nil ].
	source := self text asString copy.
	highlighterProcess := [ wantsHighlighting := false.
	highlighter text: source asText.
	highlighter parse: source.
	self text size = highlighter text runs size
		ifTrue: [ self text runs: highlighter text runs ].
	highlighterProcess := nil.
	self changed ] forkAt: Processor userBackgroundPriority
]

{ #category : 'accessing' }
ViennaPluggableTextMorph >> highlightingEnabled [
	^ highlighter notNil
]

{ #category : 'accessing' }
ViennaPluggableTextMorph >> highlightingEnabled: aBoolean [
	aBoolean = true
		ifTrue: [ 
			highlighter := ViennaVDMHighlighter new.
			self startStepping.
			self wantsHighlighting: true ]
		ifFalse: [ highlighter := nil.
			[self text runs: self text asString asText runs ] on: Error do: [:ex |]]
]

{ #category : 'initialize-release' }
ViennaPluggableTextMorph >> initialize [
	super initialize.
	wantsHighlighting := false.
	self highlightingEnabled: self class defaultHighlightingEnabled 
]

{ #category : 'event handling' }
ViennaPluggableTextMorph >> keyStroke: aKeyboardEvent [
	wantsHighlighting := true.
	^ super keyStroke: aKeyboardEvent
]

{ #category : 'menu commands' }
ViennaPluggableTextMorph >> prettyPrint [
	self handleEdit: [ self textMorph editor prettyPrint ].
	self wantsHighlighting: true
]

{ #category : 'stepping and presenter' }
ViennaPluggableTextMorph >> step [
	self wantsHighlighting
		ifTrue: [ self highlight  ].
	
]

{ #category : 'stepping and presenter' }
ViennaPluggableTextMorph >> stepTime [
	^ 1000
]

{ #category : 'menu commands' }
ViennaPluggableTextMorph >> template [
	self handleEdit: [ self textMorph editor template ]
]

{ #category : 'class access' }
ViennaPluggableTextMorph >> textAreaClass [
	^ ViennaTextMorphForEditView
]

{ #category : 'class access' }
ViennaPluggableTextMorph >> textMorphClass [
	"Answer the class used to create the receiver's textMorph"
	
	^ViennaTextMorphForEditView 
]

{ #category : 'enabling/disabling' }
ViennaPluggableTextMorph >> toggleHighlighting [
	self highlightingEnabled: self highlightingEnabled not
]

{ #category : 'updating' }
ViennaPluggableTextMorph >> update: aSymbol [
	(aSymbol == getTextSelector and: [ self canDiscardEdits not ])
		ifTrue: [ | choice |
			choice := UIManager default
				confirm: 'Code has been modified.\What do you want to do?' translated withCRs
				trueChoice: 'Accept' translated
				falseChoice: 'Discard' translated
				cancelChoice: 'Cancel' translated
				default: nil.
			choice ifNil: [ ^ nil ].
			choice
				ifTrue: [ self hasUnacceptedEdits: false.
					self textArea model
						perform: setTextSelector
						with: self textMorph text ] ].
	^ super update: aSymbol
]

{ #category : 'accessing' }
ViennaPluggableTextMorph >> updateTextWith: stringOrText [
	super updateTextWith: stringOrText.
	self highlight
]

{ #category : 'accessing' }
ViennaPluggableTextMorph >> wantsHighlighting [
	^ wantsHighlighting = true
]

{ #category : 'accessing' }
ViennaPluggableTextMorph >> wantsHighlighting: aBoolean [
	wantsHighlighting := aBoolean = true
]

{ #category : 'testing' }
ViennaPluggableTextMorph >> wantsSteps [
	^ self highlightingEnabled
]
