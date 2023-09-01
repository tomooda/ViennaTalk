Extension { #name : #ViennaLetExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaLetExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self localDefinitionList reverseDo: [ :localDefinition |
		aViennaSlicer onNode: localDefinition do: [
			aViennaSlicer
				write: localDefinition;
				read: localDefinition expression ].
		localDefinition expression sliceWith: aViennaSlicer ]
]
