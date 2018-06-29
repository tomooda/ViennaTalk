Class {
	#name : #ViennaLiveTranslationEditor,
	#superclass : #ComposableModel,
	#instVars : [
		'sourceText',
		'targetText',
		'translator'
	],
	#category : 'ViennaTalk-Parser-UI'
}

{ #category : #specs }
ViennaLiveTranslationEditor class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :c | 
					c
						add: #sourceText;
						addSplitter;
						add: #targetText ];
		yourself
]

{ #category : #'initialize-release' }
ViennaLiveTranslationEditor >> initializeWidgets [
	sourceText := self newText.
	sourceText autoAccept: true.
	sourceText
		whenTextChanged: [ :source | targetText accept: (self translate: source ifError: [ :error | '' ]) notifying: nil ].
	targetText := self newText.
	self title: 'VDM->Smalltalk'
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> sourceText [
	^ sourceText
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> targetText [
	^ targetText
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translate: aTextOrString ifError: errorBlock [
	^ (self translator parse: aTextOrString asString)
		in: [ :result | 
			result isPetitFailure
				ifTrue: [ errorBlock value: result ]
				ifFalse: [ (RBParser parseExpression: result) formattedCode ] ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translator [
	^ translator ifNil: [ translator := self translatorClass new ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translatorClass [
	^ self subclassResponsibility
]
