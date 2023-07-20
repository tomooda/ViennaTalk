Extension { #name : #ViennaAssignStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAssignStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		self expression sliceWith: aViennaSlicer.
		aViennaSlicer write: self stateDesignator ]
]
