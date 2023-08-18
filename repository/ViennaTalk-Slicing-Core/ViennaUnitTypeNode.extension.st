Extension { #name : #ViennaUnitTypeNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaUnitTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
