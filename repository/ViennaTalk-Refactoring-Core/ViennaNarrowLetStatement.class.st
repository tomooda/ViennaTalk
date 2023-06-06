Class {
	#name : #ViennaNarrowLetStatement,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetStatement >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetStatementNode
]

{ #category : #accessing }
ViennaNarrowLetStatement >> sortingOrder [
	^ 3.51
]
