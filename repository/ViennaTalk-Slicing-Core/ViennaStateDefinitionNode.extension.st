Extension { #name : 'ViennaStateDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaStateDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
