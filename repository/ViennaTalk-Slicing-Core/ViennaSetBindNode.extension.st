Extension { #name : #ViennaSetBindNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSetBindNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
