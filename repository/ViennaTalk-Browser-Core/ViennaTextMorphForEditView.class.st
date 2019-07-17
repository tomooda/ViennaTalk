Class {
	#name : #ViennaTextMorphForEditView,
	#superclass : #TextMorphForEditView,
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'class access' }
ViennaTextMorphForEditView >> editorClass [
	"Answer the class used to create the receiver's editor"

	^ ViennaEditor
]
