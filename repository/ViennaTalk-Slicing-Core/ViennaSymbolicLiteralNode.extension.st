Extension { #name : #ViennaSymbolicLiteralNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSymbolicLiteralNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
