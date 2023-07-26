Extension { #name : #ViennaTypeNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
