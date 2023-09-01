Extension { #name : #ViennaTupleSelectNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTupleSelectNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
