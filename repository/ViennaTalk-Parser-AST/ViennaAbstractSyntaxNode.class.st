Class {
	#name : #ViennaAbstractSyntaxNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaAbstractSyntaxNode class >> isAbstract [

	^ self = ViennaAbstractSyntaxNode
]

{ #category : #'pretty printing' }
ViennaAbstractSyntaxNode >> formatWith: aViennaAbstractFormatter [

	^ self subclassResponsibility
]

{ #category : #'pretty printing' }
ViennaAbstractSyntaxNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock3 value
]

{ #category : #'pretty printing' }
ViennaAbstractSyntaxNode >> operatorPrecedence [

	^ 0
]

{ #category : #comparing }
ViennaAbstractSyntaxNode >> sameAs: aViennaNode [

	self class = aViennaNode class ifFalse: [ ^ false ].
	1 to: self size do: [ :index |
		| node |
		node := self at: index.
		node isViennaNode
			ifTrue: [
			(node sameAs: (aViennaNode at: index)) ifFalse: [ ^ false ] ]
			ifFalse: [ node = (aViennaNode at: index) ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : #initialization }
ViennaAbstractSyntaxNode >> setLabel: aString [

	aString = self label ifFalse: [ self error: 'Label mismatch' ].
	label := aString
]
