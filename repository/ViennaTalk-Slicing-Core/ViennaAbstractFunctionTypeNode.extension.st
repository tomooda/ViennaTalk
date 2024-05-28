Extension { #name : 'ViennaAbstractFunctionTypeNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaAbstractFunctionTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self argumentType;
			read: self returnType ].
	self returnType sliceWith: aViennaSlicer.
	self argumentType sliceWith: aViennaSlicer
]
