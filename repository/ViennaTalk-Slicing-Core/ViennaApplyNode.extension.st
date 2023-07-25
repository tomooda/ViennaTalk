Extension { #name : #ViennaApplyNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer call: self expression.
		self arguments do: [ :expression |
			expression sliceWith: aViennaSlicer ].
		self expression sliceWith: aViennaSlicer.
		aViennaSlicer write: self ]
]
