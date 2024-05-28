Extension { #name : 'ViennaLetStatementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaLetStatementNode >> sliceWith: aViennaSlicer [

	self statement sliceWith: aViennaSlicer.
	self localDefinitionList reverseDo: [ :localDefinition |
		aViennaSlicer onNode: localDefinition do: [
			aViennaSlicer
				write: localDefinition;
				read: localDefinition expression ].
		localDefinition expression sliceWith: aViennaSlicer ]
]
