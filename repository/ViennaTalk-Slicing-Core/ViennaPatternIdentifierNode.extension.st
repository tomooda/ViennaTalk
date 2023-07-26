Extension { #name : #ViennaPatternIdentifierNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaPatternIdentifierNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
