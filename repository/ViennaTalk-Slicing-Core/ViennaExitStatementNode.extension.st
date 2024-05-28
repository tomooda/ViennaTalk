Extension { #name : 'ViennaExitStatementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaExitStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expression ifNotNil: [ :expression |
			aViennaSlicer read: expression ] ].
	self expression ifNotNil: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
