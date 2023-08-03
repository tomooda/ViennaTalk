Extension { #name : #ViennaIotaExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaIotaExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self bind sliceWith: aViennaSlicer
]
