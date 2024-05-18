Class {
	#name : 'ViennaQuoteTypeNode',
	#superclass : 'ViennaTypeNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaQuoteTypeNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : 'converting' }
ViennaQuoteTypeNode >> asMaximalViennaType [

	^ ViennaType quote:
		  (self string copyFrom: 2 to: self string size - 1) asSymbol
]

{ #category : 'pretty printing' }
ViennaQuoteTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter typeName: self string
]

{ #category : 'private' }
ViennaQuoteTypeNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'testing' }
ViennaQuoteTypeNode >> isViennaQuoteTypeNode [

	^ true
]

{ #category : 'testing' }
ViennaQuoteTypeNode >> isViennaQuoteTypeNode: aString [

	^ self string = aString
]

{ #category : 'accessing' }
ViennaQuoteTypeNode >> label [

	^ 'QuoteType'
]

{ #category : 'accessing' }
ViennaQuoteTypeNode >> string [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaQuoteTypeNode >> string: aString [

	self at: 1 put: aString
]
