Extension { #name : #ViennaDefStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaDefStatementNode >> sliceWith: aViennaSlicer [

	self statement sliceWith: aViennaSlicer.
	self equalDefinitionList reverseDo: [ :equalDefinition |
		aViennaSlicer onNode: equalDefinition do: [
			aViennaSlicer
				write: equalDefinition;
				read: equalDefinition expression ].
		equalDefinition expression sliceWith: aViennaSlicer ]
]
