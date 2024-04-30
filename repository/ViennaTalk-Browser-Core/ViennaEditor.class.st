Class {
	#name : 'ViennaEditor',
	#superclass : 'RubTextEditor',
	#instVars : [
		'template'
	],
	#category : 'ViennaTalk-Browser-Core-Morphic',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Morphic'
}

{ #category : 'class initialization' }
ViennaEditor class >> initialize [
	super initialize
]

{ #category : 'notifying' }
ViennaEditor >> notify: aString at: anInteger in: aStream [
	| pos |
	pos := self selectionInterval notEmpty
		ifTrue: [ self startIndex + anInteger - 1 ]
		ifFalse: [ anInteger ].
	self insertAndSelect: aString at: (pos max: 1)
]

{ #category : 'typing support' }
ViennaEditor >> openTypeIn [
	"Set up startOfTyping to keep track of the leftmost backspace.
	 You can't undo typing until after closeTypeIn."

	template := nil.
	self applyAttribute: TextColor black.
	self viennaTextMorph ifNotNil: [ :m | m wantsHighlighting: true ].
	^ super openTypeIn
]

{ #category : 'editing keys' }
ViennaEditor >> prettyPrint [

	[ 
	| formattedSource |
	formattedSource := ViennaVDMParser new format: self text.
	formattedSource isPetit2Failure ifFalse: [ 
		self selectInvisiblyFrom: 1 to: self paragraph text size.
		self replaceSelectionWith: formattedSource.
		self selectAt: 1 ] ]
		on: Error
		do: [ :ex |  ]
]

{ #category : 'editing keys' }
ViennaEditor >> save: aKeyboardEvent [
	self closeTypeIn.
	self accept.
	^ true
]

{ #category : 'editing keys' }
ViennaEditor >> template [
	template := ViennaSyntaxTemplate current.
	self selection ifEmpty: [ self selectWord ].
	self replaceSelectionWith: (template at: self selection asString ifAbsent: [ ^ nil ])
]

{ #category : 'accessing' }
ViennaEditor >> viennaTextMorph [
	| textMorph |
	textMorph := self morph.
	[ textMorph notNil and: [ textMorph isKindOf: ViennaPluggableTextMorph ] ] whileFalse: [ textMorph := textMorph owner ].
	^ textMorph
]
