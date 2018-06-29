Class {
	#name : #ViennaLiveTranslationEditor,
	#superclass : #ComposableModel,
	#instVars : [
		'sourceText',
		'targetText',
		'translator',
		'process'
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

{ #category : #accessing }
ViennaLiveTranslationEditor >> defaultTitle [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> format: aString [
	^ aString
]

{ #category : #'initialize-release' }
ViennaLiveTranslationEditor >> initializeWidgets [
	sourceText := self newText.
	sourceText autoAccept: true.
	sourceText
		whenTextChanged: [ :source | 
			process ifNotNil: [ process terminate ].
			process := [ 
			[ 
			targetText
				accept:
					(self
						translate: source
						ifError: [ :error | 
							[ sourceText text: (sourceText text in: [ :t | t addAttribute: TextColor red from: error position + 1 to: t size ]) ]
								fork.
							'' ])
				notifying: nil ]
				on: Error
				do: [ :ex |  ] ] forkAt: Processor userBackgroundPriority ].
	targetText := self newText.
	self title: self defaultTitle
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
				ifFalse: [ self format: result ] ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translator [
	^ translator ifNil: [ translator := self translatorClass new ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translatorClass [
	^ self subclassResponsibility
]
