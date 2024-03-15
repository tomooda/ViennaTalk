Class {
	#name : #ViennaTextMorphForEditView,
	#superclass : #RubEditingArea,
	#category : #'ViennaTalk-Browser-Core-Morphic'
}

{ #category : #'class access' }
ViennaTextMorphForEditView >> editorClass [
	"Answer the class used to create the receiver's editor"

	^ ViennaEditor
]
