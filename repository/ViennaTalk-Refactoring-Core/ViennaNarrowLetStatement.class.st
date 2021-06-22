Class {
	#name : #ViennaNarrowLetStatement,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetStatement >> acceptsAstLabel: aString [
	^ aString = 'LetStatement'
]

{ #category : #accessing }
ViennaNarrowLetStatement >> sortingOrder [
	^ 3.51
]
