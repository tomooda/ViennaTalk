Extension { #name : 'ViennaAssignmentDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaAssignmentDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		self expression ifNotNil: [ :expression |
			aViennaSlicer read: expression ].
		self type ifNotNil: [ :type | aViennaSlicer read: type ].
		aViennaSlicer write:
			((ViennaLocalNameNode identifier: self identifier)
				 parent: self;
				 yourself) ].
	self type ifNotNil: [ :type | type sliceWith: aViennaSlicer ].
	self expression ifNotNil: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
