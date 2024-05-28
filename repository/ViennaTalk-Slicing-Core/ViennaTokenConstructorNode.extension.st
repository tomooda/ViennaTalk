Extension { #name : 'ViennaTokenConstructorNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTokenConstructorNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
