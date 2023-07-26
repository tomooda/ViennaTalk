Extension { #name : #ViennaReturnStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaReturnStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: (self detectParent: #isOperationDefinition ifNone: [ nil ]);
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
