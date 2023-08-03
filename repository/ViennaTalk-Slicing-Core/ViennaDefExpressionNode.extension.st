Extension { #name : #ViennaDefExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaDefExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self equalDefinitionList reverseDo: [ :equalDefinition |
		aViennaSlicer onNode: equalDefinition do: [
			aViennaSlicer
				write: equalDefinition;
				read: equalDefinition expression ].
		equalDefinition expression sliceWith: aViennaSlicer ]
]
