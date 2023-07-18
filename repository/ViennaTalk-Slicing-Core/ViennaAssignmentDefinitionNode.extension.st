Extension { #name : #ViennaAssignmentDefinitionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAssignmentDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer node: self do: [
		self expression ifNotNil: [ :expression |
			expression sliceWith: aViennaSlicer ].
		aViennaSlicer write:
			((ViennaLocalNameNode identifier: self identifier)
				 parent: self;
				 yourself) ]
]
