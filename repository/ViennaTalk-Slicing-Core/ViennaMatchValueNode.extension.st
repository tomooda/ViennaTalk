Extension { #name : 'ViennaMatchValueNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMatchValueNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
