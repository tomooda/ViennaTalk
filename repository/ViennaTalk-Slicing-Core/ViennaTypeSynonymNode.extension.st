Extension { #name : 'ViennaTypeSynonymNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeSynonymNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
