Extension { #name : #ViennaReturnStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaReturnStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer initializeAgenda.
	aViennaSlicer onNode: self do: [
		aViennaSlicer write:
			(self detectParent: #isOperationDefinition ifNone: [ nil ]).
		self expression ifNotNil: [ :expression |
			aViennaSlicer read: expression ] ].
	self expression ifNotNil: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
