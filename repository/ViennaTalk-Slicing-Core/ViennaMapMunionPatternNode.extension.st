Extension { #name : 'ViennaMapMunionPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapMunionPatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self pattern1;
			read: self pattern2 ].
	self pattern2 sliceWith: aViennaSlicer.
	self pattern1 sliceWith: aViennaSlicer
]
