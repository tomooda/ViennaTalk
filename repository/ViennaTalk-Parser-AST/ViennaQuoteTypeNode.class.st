Class {
	#name : #ViennaQuoteTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaQuoteTypeNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaQuoteTypeNode >> formatWith: aViennaAbstractFormatter [

	aViennaAbstractFormatter format: self string
]

{ #category : #private }
ViennaQuoteTypeNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaQuoteTypeNode >> isViennaQuoteTypeNode [

	^ true
]

{ #category : #accessing }
ViennaQuoteTypeNode >> label [

	^ 'QuoteType'
]

{ #category : #accessing }
ViennaQuoteTypeNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaQuoteTypeNode >> string: aString [

	self at: 1 put: aString
]
