Extension { #name : 'ViennaMapletPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapletPatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self keyPattern;
			read: self valuePattern ].
	self valuePattern sliceWith: aViennaSlicer.
	self keyPattern sliceWith: aViennaSlicer
]
