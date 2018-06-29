Class {
	#name : #ViennaEditor,
	#superclass : #TextEditor,
	#category : 'ViennaTalk-Browser-Core'
}

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
