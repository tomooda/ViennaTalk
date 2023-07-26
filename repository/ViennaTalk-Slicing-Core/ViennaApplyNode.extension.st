Extension { #name : #ViennaApplyNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression.
		self argumentExpressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	aViennaSlicer call: self expression.
	self arguments do: [ :expression |
		expression sliceWith: aViennaSlicer ].
	self expression sliceWith: aViennaSlicer
]
