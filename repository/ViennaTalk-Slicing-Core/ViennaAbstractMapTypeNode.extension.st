Extension { #name : 'ViennaAbstractMapTypeNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaAbstractMapTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self domainType;
			read: self rangeType ].
	self rangeType sliceWith: aViennaSlicer.
	self domainType sliceWith: aViennaSlicer
]
