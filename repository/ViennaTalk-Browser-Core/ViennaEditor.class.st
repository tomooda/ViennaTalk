Class {
	#name : #ViennaEditor,
	#superclass : #TextEditor,
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'class initialization' }
ViennaEditor class >> initialize [
	super initialize
]

{ #category : #notifying }
ViennaEditor >> notify: aString at: anInteger in: aStream [
	| pos |
	pos := self selectionInterval notEmpty
		ifTrue: [ self startIndex + anInteger - 1 ]
		ifFalse: [ anInteger ].
	self insertAndSelect: aString at: (pos max: 1)
]

{ #category : #'typing support' }
ViennaEditor >> openTypeIn [
	"Set up startOfTyping to keep track of the leftmost backspace.
	 You can't undo typing until after closeTypeIn."

	self applyAttribute: TextColor black.
	^ super openTypeIn
]

{ #category : #'editing keys' }
ViennaEditor >> save: aKeyboardEvent [
	self closeTypeIn.
	self accept.
	^ true
]

{ #category : #accessing }
ViennaEditor >> viennaTextMorph [
	| textMorph |
	textMorph := morph.
	[ textMorph notNil and: [ textMorph isKindOf: ViennaPluggableTextMorph ] ] whileFalse: [ textMorph := textMorph owner ].
	^ textMorph
]
