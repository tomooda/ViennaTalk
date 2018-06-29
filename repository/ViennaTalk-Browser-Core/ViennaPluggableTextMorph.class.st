Class {
	#name : #ViennaPluggableTextMorph,
	#superclass : #PluggableTextMorph,
	#category : 'ViennaTalk-Browser-Core'
}

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
