Extension { #name : #ViennaAssignStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAssignStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		self stateDesignator
			sliceWriteWith: aViennaSlicer;
			sliceReadWith: aViennaSlicer.
		aViennaSlicer read: self expression ].
	self stateDesignator sliceArgumentsWith: aViennaSlicer.
	self expression sliceWith: aViennaSlicer
]
