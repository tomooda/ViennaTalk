Extension { #name : 'ViennaQuoteTypeNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaQuoteTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
