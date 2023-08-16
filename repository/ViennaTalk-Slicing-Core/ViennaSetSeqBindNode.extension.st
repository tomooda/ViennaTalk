Extension { #name : #ViennaSetSeqBindNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSetSeqBindNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self pattern sliceWith: aViennaSlicer
]
