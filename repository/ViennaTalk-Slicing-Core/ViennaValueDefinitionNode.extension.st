Extension { #name : #ViennaValueDefinitionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaValueDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		aViennaSlicer read: self expression ].
	self expression sliceWith: aViennaSlicer
]
