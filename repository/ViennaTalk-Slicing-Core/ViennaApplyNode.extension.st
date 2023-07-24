Extension { #name : #ViennaApplyNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	aViennaSlicer call: self expression.
	self arguments do: [ :expression |
		expression sliceWith: aViennaSlicer ].
	self expression sliceWith: aViennaSlicer
]
