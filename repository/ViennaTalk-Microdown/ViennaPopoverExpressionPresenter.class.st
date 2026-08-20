"
I show an expression with syntax highlighting as a pop-up content.
"
Class {
	#name : 'ViennaPopoverExpressionPresenter',
	#superclass : 'SpPopoverContentPresenter',
	#instVars : [
		'expression',
		'text'
	],
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'instance creation' }
ViennaPopoverExpressionPresenter class >> expression: aString [

	^ (self on: aString) yourself
]

{ #category : 'api - focus' }
ViennaPopoverExpressionPresenter >> defaultKeyboardFocus [

	^ text
]

{ #category : 'accessing' }
ViennaPopoverExpressionPresenter >> expression [

	^ expression
]

{ #category : 'accessing' }
ViennaPopoverExpressionPresenter >> expression: anObject [

	expression := anObject
]

{ #category : 'initialization' }
ViennaPopoverExpressionPresenter >> initializePresenters [

	self initializeText.

	self layout: (SpBoxLayout newTopToBottom
		add: text expand: false;
		yourself).

	text addShortcutWith: [ :action | action 
		shortcutKey: Character escape asKeyCombination 			
			| Character backspace asKeyCombination 
			| Character cr asKeyCombination;
		action: [ self dismiss ] ]
]

{ #category : 'initialization' }
ViennaPopoverExpressionPresenter >> initializeText [

	text := self newText
		beNotWrapWord;
		propagateNaturalWidth: true;
		propagateNaturalHeight: false;
		editable: false;
		text: self expression;
		addStyle: 'print';
		yourself
]

{ #category : 'api - focus' }
ViennaPopoverExpressionPresenter >> setModelBeforeInitialization: aString [

	expression := aString
]
