Extension { #name : 'ViennaDurationStatementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaDurationStatementNode >> sliceWith: aViennaSlicer [

	self statement sliceWith: aViennaSlicer.
	aViennaSlicer
		onNode: self
		do: [ aViennaSlicer read: self expression ].
	self expression sliceWith: aViennaSlicer
]
