Extension { #name : #ViennaBasicTypeNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaBasicTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
