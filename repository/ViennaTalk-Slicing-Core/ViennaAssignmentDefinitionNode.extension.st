Extension { #name : #ViennaAssignmentDefinitionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAssignmentDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		self expression ifNotNil: [ :expression |
			aViennaSlicer read: expression ].
		aViennaSlicer write:
			((ViennaLocalNameNode identifier: self identifier)
				 parent: self;
				 yourself) ].
	self expression ifNotNil: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
