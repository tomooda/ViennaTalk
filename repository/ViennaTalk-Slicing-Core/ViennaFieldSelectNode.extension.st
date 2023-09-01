Extension { #name : #ViennaFieldSelectNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaFieldSelectNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
