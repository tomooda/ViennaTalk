Extension { #name : 'ViennaExplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaExplicitOperationDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	self statement sliceWith: aViennaSlicer
]
