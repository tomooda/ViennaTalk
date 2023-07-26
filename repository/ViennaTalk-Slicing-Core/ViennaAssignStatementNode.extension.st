Extension { #name : #ViennaAssignStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAssignStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self stateDesignator;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
