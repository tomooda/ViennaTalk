Class {
	#name : 'ViennaTextMorphForEditView',
	#superclass : 'RubEditingArea',
	#category : 'ViennaTalk-Browser-Core-Morphic',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Morphic'
}

{ #category : 'class access' }
ViennaTextMorphForEditView >> editorClass [
	"Answer the class used to create the receiver's editor"

	^ ViennaEditor
]
