Class {
	#name : #ViennaNarrowLetExpression,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetExpression >> acceptsAstLabel: aString [
	^ aString = 'LetExpression'
]

{ #category : #accessing }
ViennaNarrowLetExpression >> sortingOrder [
	^ 3.52
]
